namespace :greet do
    desc "Helloを出力する．バッチ処理のテスト"
    task say_hello: :environment do
        puts "Hello!"
    end
end
