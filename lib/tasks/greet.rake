require 'uri'
require 'net/http'
require 'openssl'
require 'json'


namespace :greet do
    desc "Helloを出力する．バッチ処理のテスト"
    task say_hello: :environment do
        puts "Hello!"
    end
end

namespace :tennis do
    desc "APIから試合情報を取得する"
    task fetch_match_info: :environment do
        # 最後の数字がトーナメントのID
        '''
        tourament_id = "1367"
        url = URI("https://tennis-live-data.p.rapidapi.com/matches-results/"+tourament_id)
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
        puts result_matches
        '''
        '''
        response_read_body = (Response.find(1)).data
        response_body_json = JSON.parse(response_read_body)
        result_matches = response_body_json["results"]["matches"]
        '''
        @tournament_year = TournamentYear.find_by(api_id: 1368)
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
            day = Time.zone.parse(result_match["date"])
            
            if !day.to_date.before? @tournament_year.first_day
                
                home_player = Player.find_by(name: result_match["home_player"])
                home_player ||= Player.create(name: result_match["home_player"])

                away_player = Player.find_by(name: result_match["away_player"])
                away_player ||= Player.create(name: result_match["away_player"])

                # 該当するmatch があるか，調べる
                match_query = Match.joins(:home_player, :away_player, :tournament_year).where(home_player_id: home_player.id, away_player_id: away_player.id, tournament_year_id: @tournament_year.id)
                if match_query.length == 0
                    # 該当するmatchがない場合
                    
                    match = Match.create(day: day, tournament_year_id: @tournament_year.id, home_player_id: home_player.id, away_player_id: away_player.id)
                    home_player_match = match.player_matches.create(player_id: home_player.id)
                    away_player_match = match.player_matches.create(player_id: away_player.id)
            
                else
                    match_id = match_query[0].id
                    match = Match.find(match_id)
                end

                tournament_year_and_home_player = TournamentYearAndPlayer.joins(:tournament_year, :player).find_by(tournament_year:  @tournament_year.id, player: home_player.id)
                tournament_year_and_home_player ||= TournamentYearAndPlayer.create(tournament_year_id: @tournament_year.id, player_id: home_player.id, remain_flag: 't')
                tournament_year_and_away_player = TournamentYearAndPlayer.joins(:tournament_year, :player).find_by(tournament_year:  @tournament_year.id, player: away_player.id)
                tournament_year_and_away_player ||= TournamentYearAndPlayer.create(tournament_year_id: @tournament_year.id, player_id: away_player.id, remain_flag: 't')

                if !result_match["result"].nil?
                    # 試合結果が出ている場合
                    if result_match["result"]["winner_id"] == result_match["home_id"]
                        # home_player が勝った場合
                        match.update(win_player_id: home_player.id)
                        tournament_year_and_away_player.update(remain_flag: 'f')
                    else
                        # away_player が勝った場合
                        match.update(win_player_id: away_player.id)
                        tournament_year_and_home_player.update(remain_flag: 'f')

                    end
                end
                
            end
        end
    end
end

