require 'uri'
require 'net/http'
require 'openssl'
require 'json'
require 'line_notify'

ONEDAYHOUR = 24


namespace :greet do
    desc "Helloを出力する．バッチ処理のテスト"
    task say_hello: :environment do
        puts "Hello!"
    end
end

namespace :tennis do
    desc "APIから試合情報を取得する"
    task fetch_match_info: :environment do
        tbt_player_name_list = ['R64p', 'R32p', 'R16p', 'R4p', 'Qf', 'Wqf', 'Wsf']
        
        today = Time.zone.now
        today_date_string = today.strftime("%Y-%m-%d")
        @batch_schedules = BatchSchedule.where('start_day <= ? AND end_day >= ?', today_date_string, today_date_string)
        @batch_schedules.each do |batch_schedule|
            fetch_api_timing_flag = false
            current_hour = today.hour
            start_hour = batch_schedule.start_hour
            add_one_day_hour_flag = false
            if start_hour > current_hour
                current_hour += ONEDAYHOUR
                add_one_day_hour_flag = true
            end
            
            if (add_one_day_hour_flag && (today_date_string.to_date - batch_schedule.start_day).to_i == 1) || (!add_one_day_hour_flag && batch_schedule.start_day == today_date_string.to_date) 
                # 大会初日の前日は，1 回だけ api に fetch
                if current_hour - start_hour == 6
                    fetch_api_timing_flag = true
                end
            else
                if (current_hour-start_hour) > 0 && (current_hour-start_hour) <= 15 && (current_hour-start_hour) % 3 == 0
                    fetch_api_timing_flag = true
                end
            end

            if fetch_api_timing_flag == true
                puts "OK"
               
                @tournament_year = batch_schedule.tournament_year
                url = URI("https://tennis-live-data.p.rapidapi.com/matches-results/"+@tournament_year.api_id.to_s)
                http = Net::HTTP.new(url.host, url.port)
                http.use_ssl = true
                http.verify_mode = OpenSSL::SSL::VERIFY_NONE
                request = Net::HTTP::Get.new(url)
                request["x-rapidapi-key"] = "e86e5c5e7amsh4ac322ec0b5d9ebp1b3e45jsn881daff8be48"
                request["x-rapidapi-host"] = "tennis-live-data.p.rapidapi.com"
                request["Content-Type"] = "application/json"
                response = http.request(request)
                result = Response.create(data: response.read_body)
                response_body_json = JSON.parse(response.read_body)
                result_matches = response_body_json["results"]["matches"]
                
                result_matches.each_with_index do |result_match, cnt|
                    if result_match["round_name"].include?("Qualification")
                        # 予選は登録しない
                        next
                    end

                    tbt_match_flag = false
                    tbt_player_name_list.each do |tbt_player_name|
                        if result_match["home_player"].start_with?(tbt_player_name)
                            tbt_match_flag = true
                        end
                        if result_match["away_player"].start_with?(tbt_player_name)
                            tbt_match_flag = true
                        end
                    end
                    if tbt_match_flag == true
                        next
                    end

                    day = Time.zone.parse(result_match["date"])
                    
                    if !day.to_date.before? @tournament_year.first_day
                        
                        # home_player = Player.find_or_create_by(name: result_match["home_player"])
                        home_player = Player.create_with(name: result_match["home_player"]).find_or_create_by(api_id: result_match["home_id"])

                        # away_player = Player.find_or_create_by(name: result_match["away_player"])
                        away_player = Player.create_with(name: result_match["away_player"]).find_or_create_by(api_id: result_match["away_id"])
                        
                        # home_player.update(ranking: result_match["home"]["ranking"])
                        # away_player.update(ranking: result_match["away"]["ranking"])
                        
                        # 該当するmatch があるか，調べる
                        match_query = Match.where(home_player_id: home_player.id, away_player_id: away_player.id, tournament_year_id: @tournament_year.id)
                        if match_query.length == 0
                            # 該当するmatchがない場合
                            
                            match = Match.create(day: day, tournament_year_id: @tournament_year.id, home_player_id: home_player.id, away_player_id: away_player.id)
                            home_player_match = match.player_matches.create(player_id: home_player.id)
                            away_player_match = match.player_matches.create(player_id: away_player.id)
                    
                        else
                            match = match_query[0]
                        end

                        match.update(day: day)
    
                        tournament_year_and_home_player = TournamentYearAndPlayer.find_by(tournament_year_id:  @tournament_year.id, player_id: home_player.id)
                        tournament_year_and_home_player ||= TournamentYearAndPlayer.create(tournament_year_id: @tournament_year.id, player_id: home_player.id, remain_flag: 't')
                        tournament_year_and_away_player = TournamentYearAndPlayer.find_by(tournament_year_id:  @tournament_year.id, player_id: away_player.id)
                        tournament_year_and_away_player ||= TournamentYearAndPlayer.create(tournament_year_id: @tournament_year.id, player_id: away_player.id, remain_flag: 't')
    
                        if !result_match["result"].nil?
                            # 試合結果が出ている場合
                            if result_match["result"]["winner_id"] == result_match["home_id"]
                                # home_player が勝った場合
                                match.update(win_player_id: home_player.id)
                                tournament_year_and_away_player.update(remain_flag: 'f')
                                # tournament_year_and_home_player.update(remain_flag: 't')
                            elsif result_match["result"]["winner_id"] == result_match["away_id"]
                                # away_player が勝った場合
                                match.update(win_player_id: away_player.id)
                                tournament_year_and_home_player.update(remain_flag: 'f')
                                # tournament_year_and_away_player.update(remain_flag: 't')
    
                            end
                        end
                        
                    end
                end
    
                @result_nil_matches = Match.eager_loading.where(win_player_id: nil, tournament_year_id: @tournament_year.id)
    
                @result_nil_matches.each do |result_nil_match|
                    home_player = result_nil_match.home_player
                    away_player = result_nil_match.away_player

    
                    if Match.where(home_player_id: home_player.id, tournament_year_id: @tournament_year.id).where("day > ?", result_nil_match.day).exists?
                        result_nil_match.update(win_player_id: home_player.id)
                        tournament_year_and_away_player = TournamentYearAndPlayer.where(tournament_year_id: @tournament_year.id, player_id: away_player.id)
                        tournament_year_and_away_player.update(remain_flag: 'f')
                        # tournament_year_and_home_player.update(remain_flag: 't')
                        
    
                    elsif Match.where(away_player_id: away_player.id, tournament_year_id: @tournament_year.id).where("day > ?", result_nil_match.day).exists?
                        result_nil_match.update(win_player_id: away_player.id)
                        tournament_year_and_home_player = TournamentYearAndPlayer.where(tournament_year_id: @tournament_year.id, player_id: home_player.id)
                        tournament_year_and_home_player.update(remain_flag: 'f')
                        # tournament_year_and_away_player.update(remain_flag: 't')

                    elsif Match.where(home_player_id: away_player.id, tournament_year_id: @tournament_year.id).where("day > ?", result_nil_match.day).exists?
                        result_nil_match.update(win_player_id: away_player.id)
                        tournament_year_and_home_player = TournamentYearAndPlayer.where(tournament_year_id: @tournament_year.id, player_id: home_player.id)
                        tournament_year_and_home_player.update(remain_flag: 'f')
                        # tournament_year_and_away_player.update(remain_flag: 't')
                
                    elsif Match.where(away_player_id: home_player.id, tournament_year_id: @tournament_year.id).where("day > ?", result_nil_match.day).exists?
                        result_nil_match.update(win_player_id: home_player.id)
                        tournament_year_and_away_player = TournamentYearAndPlayer.where(tournament_year_id: @tournament_year.id, player_id: away_player.id)
                        tournament_year_and_away_player.update(remain_flag: 'f')
                        # tournament_year_and_home_player.update(remain_flag: 't')
                    end
    
                end
    
                if @tournament_year.champion.nil?
                    remain_players_cnt = TournamentYearAndPlayer.where(tournament_year_id: @tournament_year.id, remain_flag: 't').size
                    if remain_players_cnt == 1
                        champion_id = TournamentYearAndPlayer.find_by(tournament_year_id: @tournament_year.id, remain_flag: 't').player.id
                        @tournament_year.update(champion_id: champion_id)
                    end
                end
    
            end

        end
    end
    desc "api_idで指定したtournamentの情報を取得"
    task fetch_tournament_info: :environment do

        tbt_player_name_list = ['R64p', 'R32p', 'R16p', 'R4p', 'Qf', 'Wqf', 'Wsf']
        
        api_id = 1456
               
        @tournament_year = TournamentYear.find_by(api_id: api_id)
        url = URI("https://tennis-live-data.p.rapidapi.com/matches-results/"+@tournament_year.api_id.to_s)
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        request = Net::HTTP::Get.new(url)
        request["x-rapidapi-key"] = "e86e5c5e7amsh4ac322ec0b5d9ebp1b3e45jsn881daff8be48"
        request["x-rapidapi-host"] = "tennis-live-data.p.rapidapi.com"
        request["Content-Type"] = "application/json"
        response = http.request(request)
        result = Response.create(data: response.read_body)
        response_body_json = JSON.parse(response.read_body)
        result_matches = response_body_json["results"]["matches"]
        
        result_matches.each_with_index do |result_match, cnt|
            if result_match["round_name"].include?("Qualification")
                # 予選は登録しない
                next
            end

            tbt_match_flag = false
            tbt_player_name_list.each do |tbt_player_name|
                if result_match["home_player"].start_with?(tbt_player_name)
                    tbt_match_flag = true
                end
                if result_match["away_player"].start_with?(tbt_player_name)
                    tbt_match_flag = true
                end
            end
            if tbt_match_flag == true
                next
            end

            day = Time.zone.parse(result_match["date"])
            
            if !day.to_date.before? @tournament_year.first_day
                
                # home_player = Player.find_or_create_by(name: result_match["home_player"])
                home_player = Player.create_with(name: result_match["home_player"]).find_or_create_by(api_id: result_match["home_id"])

                # away_player = Player.find_or_create_by(name: result_match["away_player"])
                away_player = Player.create_with(name: result_match["away_player"]).find_or_create_by(api_id: result_match["away_id"])
                
                # home_player.update(ranking: result_match["home"]["ranking"])
                # away_player.update(ranking: result_match["away"]["ranking"])
                
                # 該当するmatch があるか，調べる
                match_query = Match.where(home_player_id: home_player.id, away_player_id: away_player.id, tournament_year_id: @tournament_year.id)
                if match_query.length == 0
                    # 該当するmatchがない場合
                    
                    match = Match.create(day: day, tournament_year_id: @tournament_year.id, home_player_id: home_player.id, away_player_id: away_player.id)
                    home_player_match = match.player_matches.create(player_id: home_player.id)
                    away_player_match = match.player_matches.create(player_id: away_player.id)
            
                else
                    match = match_query[0]
                end

                match.update(day: day)

                tournament_year_and_home_player = TournamentYearAndPlayer.find_by(tournament_year_id:  @tournament_year.id, player_id: home_player.id)
                tournament_year_and_home_player ||= TournamentYearAndPlayer.create(tournament_year_id: @tournament_year.id, player_id: home_player.id, remain_flag: 't')
                tournament_year_and_away_player = TournamentYearAndPlayer.find_by(tournament_year_id:  @tournament_year.id, player_id: away_player.id)
                tournament_year_and_away_player ||= TournamentYearAndPlayer.create(tournament_year_id: @tournament_year.id, player_id: away_player.id, remain_flag: 't')

                if !result_match["result"].nil?
                    # 試合結果が出ている場合
                    if result_match["result"]["winner_id"] == result_match["home_id"]
                        # home_player が勝った場合
                        match.update(win_player_id: home_player.id)
                        tournament_year_and_away_player.update(remain_flag: 'f')
                        # tournament_year_and_home_player.update(remain_flag: 't')
                    elsif result_match["result"]["winner_id"] == result_match["away_id"]
                        # away_player が勝った場合
                        match.update(win_player_id: away_player.id)
                        tournament_year_and_home_player.update(remain_flag: 'f')
                        # tournament_year_and_away_player.update(remain_flag: 't')

                    end
                end
                
            end
        end

        @result_nil_matches = Match.eager_loading.where(win_player_id: nil, tournament_year_id: @tournament_year.id)

        @result_nil_matches.each do |result_nil_match|
            home_player = result_nil_match.home_player
            away_player = result_nil_match.away_player


            if Match.where(home_player_id: home_player.id, tournament_year_id: @tournament_year.id).where("day > ?", result_nil_match.day).exists?
                result_nil_match.update(win_player_id: home_player.id)
                tournament_year_and_away_player = TournamentYearAndPlayer.where(tournament_year_id: @tournament_year.id, player_id: away_player.id)
                tournament_year_and_away_player.update(remain_flag: 'f')
                # tournament_year_and_home_player.update(remain_flag: 't')
                

            elsif Match.where(away_player_id: away_player.id, tournament_year_id: @tournament_year.id).where("day > ?", result_nil_match.day).exists?
                result_nil_match.update(win_player_id: away_player.id)
                tournament_year_and_home_player = TournamentYearAndPlayer.where(tournament_year_id: @tournament_year.id, player_id: home_player.id)
                tournament_year_and_home_player.update(remain_flag: 'f')
                # tournament_year_and_away_player.update(remain_flag: 't')

            elsif Match.where(home_player_id: away_player.id, tournament_year_id: @tournament_year.id).where("day > ?", result_nil_match.day).exists?
                result_nil_match.update(win_player_id: away_player.id)
                tournament_year_and_home_player = TournamentYearAndPlayer.where(tournament_year_id: @tournament_year.id, player_id: home_player.id)
                tournament_year_and_home_player.update(remain_flag: 'f')
                # tournament_year_and_away_player.update(remain_flag: 't')
        
            elsif Match.where(away_player_id: home_player.id, tournament_year_id: @tournament_year.id).where("day > ?", result_nil_match.day).exists?
                result_nil_match.update(win_player_id: home_player.id)
                tournament_year_and_away_player = TournamentYearAndPlayer.where(tournament_year_id: @tournament_year.id, player_id: away_player.id)
                tournament_year_and_away_player.update(remain_flag: 'f')
                # tournament_year_and_home_player.update(remain_flag: 't')
            end

        end

        if @tournament_year.champion.nil?
            remain_players_cnt = TournamentYearAndPlayer.where(tournament_year_id: @tournament_year.id, remain_flag: 't').size
            if remain_players_cnt == 1
                champion_id = TournamentYearAndPlayer.find_by(tournament_year_id: @tournament_year.id, remain_flag: 't').player.id
                @tournament_year.update(champion_id: champion_id)
            end
        end

    end

    desc "選手のランキングの情報を取得"
    task fetch_player_ranking_info: :environment do
        url = URI("https://tennis-live-data.p.rapidapi.com/rankings/ATP")

        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE

        request = Net::HTTP::Get.new(url)
        request["x-rapidapi-key"] = 'e86e5c5e7amsh4ac322ec0b5d9ebp1b3e45jsn881daff8be48'
        request["x-rapidapi-host"] = 'tennis-live-data.p.rapidapi.com'

        response = http.request(request)
        result = Response.create(data: response.read_body)
        response_body_json = JSON.parse(response.read_body)

        result_players = response_body_json["results"]["rankings"]
        result_players.each do |result_player|
            api_id = result_player["id"].to_i
            name = result_player["last_name"] + " " + result_player["first_name"][0] + "."
            player = Player.create_with(name: name).find_or_create_by(api_id: api_id)
            player.update(full_name: result_player["full_name"])
            player.update(ranking: result_player["ranking"])
        end

    end

    desc "開催都市のwebカメラ映像を取得" 
    task fetch_web_cam_img: :environment do
        @cities = City.all
        @cities.each do |city|
            lat = city.latitude
            lng = city.longitude
            url = URI("https://webcamstravel.p.rapidapi.com/webcams/list/nearby=#{lat},#{lng},30?lang=en&show=webcams%3Aimage%2Clocation")

            http = Net::HTTP.new(url.host, url.port)
            http.use_ssl = true
            http.verify_mode = OpenSSL::SSL::VERIFY_NONE

            request = Net::HTTP::Get.new(url)
            request["x-rapidapi-key"] = 'e86e5c5e7amsh4ac322ec0b5d9ebp1b3e45jsn881daff8be48'
            request["x-rapidapi-host"] = 'webcamstravel.p.rapidapi.com'

            response = http.request(request)
            result = Response.create(data: response.read_body)
            response_body_json = JSON.parse(response.read_body)
            puts city.name
            puts response_body_json["result"]["total"]
            if response_body_json["result"]["total"] > 0
                city.update!(image_url: response_body_json["result"]["webcams"][0]["image"]["current"]["preview"])
            end
        end
    end

    desc "ユーザーのお気に入り選手の試合を前日に通知"
    task line_notify_favorite_player_match_before_day: :environment do
        today = Time.zone.now

        User.all.each do |user|
            line_notify_message = ""
            user.favorite_players.each do |favorite_player|
                player_match_day_message = favorite_player.name + "の試合が明日"
                player_matches = PlayerMatch.joins(:match).where(player_id: favorite_player.id).where("matches.day >= ? AND matches.day < ?", today+60*60*24, today+60*60*25)
                match_day_message = ""
                player_matches.each do |player_match|
                    match_day_message += player_match.match.day.strftime("%H:%M")
                end
                unless match_day_message == ""
                    player_match_day_message += match_day_message +"からあります．\n"
                    line_notify_message += player_match_day_message
                end
            end
            unless line_notify_message == ""
                # line notify で通知
                puts line_notify_message
                line_notify = LineNotify.new("xxxxxxxxx")
                options = {message: line_notify_message}
                line_notify.ping(options)
            end
        end
    end

    desc "ユーザーのお気に入り選手の試合を1時間前ほどから通知"
    task line_notify_favorite_player_match_before_one_hour: :environment do
        today = Time.zone.now

        User.all.each do |user|
            line_notify_message = ""
            user.favorite_players.each do |favorite_player|
                player_match_day_message = favorite_player.name + "の試合が"
                player_matches = PlayerMatch.joins(:match).where(player_id: favorite_player.id).where("matches.day >= ? AND matches.day < ?", today, today+60*60*30)
                match_day_message = ""
                player_matches.each do |player_match|
                    match_day_message += player_match.match.day.strftime("%H:%M") + " "
                end
                unless match_day_message == ""
                    player_match_day_message += match_day_message +"からはじまります．\n"
                    line_notify_message += player_match_day_message
                end
            end
            unless line_notify_message == ""
                # line notify で通知
                puts line_notify_message
                line_notify = LineNotify.new("xxxxxxxxx")
                options = {message: line_notify_message}
                line_notify.ping(options)
            end
        end
    end

    desc "お試し"
    task trial: :environment do 
        @tournament_year = TournamentYear.find(2)
        Rake::Task["tennis:line_notify_tournament_start"].invoke(@tournament_year)
    end

    desc "大会が明日から開催されることをユーザーに通知"
    task :line_notify_tournament_start, [:tournament_year] => :environment do |task, args|
        @tournament_year = args.tournament_year
        User.all.each do |user|
            access_token_of_line_notify = user.access_token_of_line_notify
            if access_token_of_line_notify == ""
                next
            end
            tournament_tomorrow_start_message = @tournament_year.tournament.name + "が明日から開幕します．\n"
            tournament_tomorrow_start_message += "開催都市は，" + @tournament_year.tournament.city.name + "です！\n"
            tournament_tomorrow_start_message += @tournament_year.tournament.city.name + "のwebカメラはこちらからチェックできます！少しでも現地気分を味わってみてください ^^)\n" 
            tournament_tomorrow_start_message += @tournament_year.tournament.city.image_url
            line_notify = LineNotify.new(access_token_of_line_notify)
            options = {message: tournament_tomorrow_start_message}
            line_notify.ping(options)
        end
    end
end

