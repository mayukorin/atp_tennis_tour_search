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
        response_read_body = (Response.find(1)).data
        response_body_json = JSON.parse(response_read_body)
        result_matches = response_body_json["results"]["matches"]
        # puts response_body_json
        # puts response_body_json.class
        # puts result_matches
        # puts result_matches.class
        @tournament_year = TournamentYear.find_by(api_id: 1367)
        puts @tournament_year.first_day
        result_matches.each_with_index do |result_match, cnt|
            # puts result_match["date"]
            # if !result_match["date"].to_date.before? @tournament_year.first_day
            # if !day.before? @tournament_year.first_day
            # 本選だけ，DBに書き込む
                
            if cnt == 0
                home_player = Player.find_by(name: result_match["home_player"])
                home_player ||= Player.create(name: result_match["home_player"])

                away_player = Player.find_by(name: result_match["away_player"])
                away_player ||= Player.create(name: result_match["away_player"])

                # 該当するmatch があるか，調べる
                match_query = PlayerMatch.joins(:player, {match: :tournament_year}).select('match.id').where(player: { name: [home_player.name, away_player.name] }).where(match: { tournament_year: @tournament_year.id}).group('match.id').having('count(*) > ?', 1)
                if match_query.length == 0
                    # 該当するmatchがない場合
                    # 入る?
                    day =  Time.zone.parse(result_match["date"])
                    puts day
                    match = Match.create(day: day, tournament_year_id: @tournament_year.id)
                end
            end

        end


    end
end