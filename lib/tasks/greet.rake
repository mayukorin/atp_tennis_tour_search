require 'uri'
require 'net/http'
require 'openssl'
require 'json'


namespace :greet do
    desc "Helloを出力する．バッチ処理のテスト"
    task say_hello: :environment do
        puts "Hello!"
        result = Response.create(data: "hello")
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
        '''
        response_read_body = (Response.find(2)).data
        response_body_json = JSON.parse(response_read_body)
        result_matches = response_body_json["results"]["matches"]
        # puts response_body_json
        # puts response_body_json.class
        # puts result_matches
        # puts result_matches.class
        @tournament_year = TournamentYear.find_by(api_id: 1367)
        
        # aa = PlayerMatch.where(player.name: ["ジョコビッチ", "錦織圭"])
        # aa = PlayerMatch.joins(:player, {match: :tournament_year}).where(player: { name: ["ジョコビッチ", "錦織圭"] }).where(match: { tournament_year: { id: 4 }})
        # c = Match.joins(:tournament_year).find_by(id: 1, tournament_year: 1)
        # puts c
        # c.update(day: "2021-08-25T01:25:00+00:00")
        # aa = PlayerMatch.joins(:player, {match: :tournament_year}).where(player: { name: ["ジョコビッチ", "錦織圭"] })
        # puts aa[0].id
        # puts aa.to_sql
        # puts aa.length
        '''
        aa.each do |a|
            puts a.id
        end
        '''
        # puts result_matches
        result_matches.each_with_index do |result_match, cnt|
            # puts result_match["date"]
            if !result_match["date"].to_date.before? @tournament_year.first_day
                # 本選だけ，DBに書き込む
                home_player = Player.find_by(name: result_match["home_player"])
                home_player ||= Player.create(name: result_match["home_player"])

                away_player = Player.find_by(name: result_match["away_player"])
                away_player ||= Player.create(name: result_match["away_player"])

                # 該当するmatch があるか，調べる
                match_query = PlayerMatch.joins(:player, {match: :tournament_year}).select('match.id').where(player: { name: [home_player.name, away_player.name] }).where(match: { tournament_year: @tournament_year.id}).group('match.id').having('count(*) > ?', 1)
                if match_query.length == 0
                    # 該当するmatchがない場合
                    # 入る?
                    match = Match.create(day: result_match["date"], tournament_year_id: @tournament_year.id)
                    home_player_match = match.player_matches.create(player_id: home_player.id, win_flag: 't')
                    away_player_match = match.player_matches.create(player_id: away_player.id, win_flag: 't')
                else 
                    # 該当するmatchがある場合
                    match_id = match_query[0].id
                    match = Match.find(match_id)
                    home_player_match = PlayerMatch.joins(:match, :player).find_by(match: match_id, player: home_player.id)
                    away_player_match = PlayerMatch.joins(:match, :player).find_by(match: match_id, player: away_player.id)
                    puts home_player_match.id
                    puts away_player_match.id
                    puts match.id
                end
                tournament_year_and_home_player = TournamentYearAndPlayer.joins(:tournament_year, :player).find_by(tournament_year:  @tournament_year.id, player: home_player.id)
                tournament_year_and_home_player ||= TournamentYearAndPlayer.create(tournament_year_id: @tournament_year.id, player_id: home_player.id, remain_flag: 't')
                tournament_year_and_away_player = TournamentYearAndPlayer.joins(:tournament_year, :player).find_by(tournament_year:  @tournament_year.id, player: away_player.id)
                tournament_year_and_away_player ||= TournamentYearAndPlayer.create(tournament_year_id: @tournament_year.id, player_id: away_player.id, remain_flag: 't')

                if !result_match["result"].nil?
                    # 試合結果が出ている場合
                    if result_match["result"]["winner_id"] == result_match["home_id"]
                        # home_player が勝った場合
                        home_player_match.update(win_flag: 't')
                        away_player_match.update(win_flag: 'f')
                        tournament_year_and_away_player.update(remain_flag: 'f')
                    else
                        # away_player が勝った場合
                        home_player_match.update(win_flag: 'f')
                        away_player_match.update(win_flag: 't')
                        tournament_year_and_home_player.update(remain_flag: 'f')

                    end
                end
            end
        end
    end
end