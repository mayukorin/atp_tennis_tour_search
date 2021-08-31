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
    end
end

namespace :trial do
    task trial: :environment do
        # @fp = Player.eager_load(player_matches: :match).where("player_matches.id in (select id from player_matches where player_id = players.id limit 2)");
        # @fp = Player.eager_load(player_matches: :match).where("player_matches.id in (select player_matches.id from player_matches left outer join matches on matches.id = match_id where player_id = players.id order by matches.day desc limit 2)");
        @fp = Player.eager_load(:matches).where("player_matches.id in (select player_matches.id from player_matches left outer join matches on matches.id = match_id where player_id = players.id order by matches.day desc limit 2)");
        @fp.each do |f|
            f.matches.each do |ma|
                puts ma.day
            end
        end
    end
end
