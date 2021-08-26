require 'uri'
require 'net/http'
require 'openssl'


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
        url = URI("https://tennis-live-data.p.rapidapi.com/matches-results/1367")
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        request = Net::HTTP::Get.new(url)
        request["x-rapidapi-key"] = 'e86e5c5e7amsh4ac322ec0b5d9ebp1b3e45jsn881daff8be48'
        request["x-rapidapi-host"] = 'tennis-live-data.p.rapidapi.com'

        response = http.request(request)
        puts response.read_body
    end
end