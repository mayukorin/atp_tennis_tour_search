# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# coding: utf-8



=begin
Tournament.create(:name => '全豪オープン', :abbreviation => 'ME', :city => 'メルボルン')
Tournament.create(:name => '全仏オープン', :abbreviation => 'PA', :city => 'パリ')
Tournament.create(:name => 'ウィンブルドン', :abbreviation => 'LO', :city => 'ロンドン')
Tournament.create(:name => '全米オープン', :abbreviation => 'NY', :city => 'ニューヨーク')

tournament = Tournament.find_by(name: '全豪オープン')
me = tournament.tournament_years.create(:year => 2021, :first_day => '2021-02-08', :last_day => '2021-02-21', :now_flag => 't', :api_id => 1283)


tournament = Tournament.find_by(name: '全仏オープン')
pa = tournament.tournament_years.create(:year => 2021, :first_day => '2021-05-30', :last_day => '2021-06-13', :now_flag => 't', :api_id => 1347)

tournament = Tournament.find_by(name: 'ウィンブルドン')
lo = tournament.tournament_years.create(:year => 2021, :first_day => '2021-06-28', :last_day => '2021-07-11', :now_flag => 't', :api_id => 1354)

tournament = Tournament.find_by(name: '全米オープン')
ny = tournament.tournament_years.create(:year => 2021, :first_day => '2021-08-30', :last_day => '2021-09-12', :now_flag => 't', :api_id => 1368)
=end
grand_slam = AtpCategory.create(:name => 'GRAND SLAM')
masters = AtpCategory.create(:name => 'Masters 1000')
atp_500 = AtpCategory.create(:name => 'ATP 500')



grand_slam = AtpCategory.find_by(:name => 'GRAND SLAM')
masters = AtpCategory.find_by(:name => 'Masters 1000')
atp_500 = AtpCategory.find_by(:name => 'ATP 500')

me = Tournament.find_by(name: '全豪オープン')
pa = Tournament.find_by(name: '全仏オープン')
lo = Tournament.find_by(name: 'ウィンブルドン')
ny = Tournament.find_by(name: '全米オープン')


grand_slam.tournaments << me
grand_slam.tournaments << pa
grand_slam.tournaments << lo
grand_slam.tournaments << ny

=begin
grand_slam.save
me << grand_slam
pa << grand_slam
lo << grand_slam
ny << grand_slam
my = Tournament.create!(:name => 'マイアミオープン', :abbreviation => 'MY', :city => 'マイアミ', :atp_category_id => 2)
lor = Tournament.create(:name => 'ロレックス・モンテカルロ・マスターズ', :abbreviation => 'LOR', :city => 'モンテカルロ', :atp_category_id => 2)
mu = Tournament.create(:name => 'ムチュア・マドリード・オープン', :abbreviation => 'MU', :city => 'マドリード', :atp_category_id => 2)
bnl = Tournament.create(:name => 'BNLイタリア国際', :abbreviation => 'BNL', :city => 'ローマ', :atp_category_id => 2)
na = Tournament.create(:name => 'ナショナルバンク・オープン', :abbreviation => 'NA', :city => 'トロント', :atp_category_id => 2)
sa = Tournament.create(:name => 'ウエスタン&サザン・オープン', :abbreviation => 'SA', :city => 'シンシナティ', :atp_category_id => 2)
shy = Tournament.create(:name => 'ロレックス上海マスターズ', :abbreviation => 'SHY', :city => '上海', :atp_category_id => 2)
bnp = Tournament.create(:name => 'BNPパリバ・オープン', :abbreviation => 'BNP', :city => 'インディアンウェルズ', :atp_category_id => 2)
lp = Tournament.create(:name => 'ロレックス・パリ・マスターズ', :abbreviation => 'LP', :city => 'パリ', :atp_category_id => 2)

abn = Tournament.create(:name => 'ABNアムロ・ワールド・テニス・トーナメント', :abbreviation => 'ABN', :city => 'ロッテルダム', :atp_category_id => 3)
dob = Tournament.create(:name => 'ドバイ・デューティフリー・テニス選手権', :abbreviation => 'DO', :city => 'ドバイ', :atp_category_id => 3)
meki = Tournament.create(:name => 'メキシコ・オープン', :abbreviation => 'MEKI', :city => 'アカプルコ', :atp_category_id => 3)
val = Tournament.create(:name => 'バルセロナ・オープン', :abbreviation => 'VAL', :city => 'バルセロナ', :atp_category_id => 3)
shin = Tournament.create(:name => 'シンチ選手権', :abbreviation => 'SHIN', :city => 'ロンドン', :atp_category_id => 3)
nov = Tournament.create(:name => 'ノベンティ・オープン', :abbreviation => 'NOV', :city => 'ハレ', :atp_category_id => 3)
han = Tournament.create(:name => 'ハンブルク・ヨーロピアン・オープン', :abbreviation => 'HAN', :city => 'ハンブルク', :atp_category_id => 3)
city = Tournament.create(:name => 'シティ・オープン', :abbreviation => 'CITY', :city => 'ワシントンD.C.', :atp_category_id => 3)
chi = Tournament.create(:name => 'チャイナ・オープン', :abbreviation => 'CHI', :city => '北京', :atp_category_id => 3)
tok = Tournament.create(:name => '楽天ジャパン・オープン', :abbreviation => 'TOK', :city => '東京', :atp_category_id => 3)
el = Tournament.create(:name => 'エルステ・バンク・オープン', :abbreviation => 'EL', :city => 'ウィーン', :atp_category_id => 3)
ind = Tournament.create(:name => 'スイス・インドア', :abbreviation => 'IN', :city => 'バーゼル', :atp_category_id => 3)

my.tournament_years.create(:year => 2021, :first_day => '2021-03-24', :last_day => '2021-04-04', :now_flag => 't', :api_id => 1334)
lor.tournament_years.create(:year => 2021, :first_day => '2021-04-11', :last_day => '2021-04-18', :now_flag => 't', :api_id => 1338)
mu.tournament_years.create(:year => 2021, :first_day => '2021-05-02', :last_day => '2021-05-09', :now_flag => 't', :api_id => 1343)
bnl.tournament_years.create(:year => 2021, :first_day => '2021-05-09', :last_day => '2021-05-16', :now_flag => 't', :api_id => 1344)
na.tournament_years.create(:year => 2021, :first_day => '2021-08-09', :last_day => '2021-08-15', :now_flag => 't', :api_id => 1365)
sa.tournament_years.create(:year => 2021, :first_day => '2021-08-15', :last_day => '2021-08-22', :now_flag => 't', :api_id => 1366)
shy.tournament_years.create(:year => 2021, :first_day => '2021-10-03', :last_day => '2021-10-10', :now_flag => 't', :api_id => 1377) # 日付け
bnp.tournament_years.create(:year => 2021, :first_day => '2021-10-07', :last_day => '2021-10-17', :now_flag => 't', :api_id => 1331) # 3 -> 10 月に
lp.tournament_years.create(:year => 2021, :first_day => '2021-11-01', :last_day => '2021-11-07', :now_flag => 't', :api_id => 1383)


abn.tournament_years.create(:year => 2021, :first_day => '2021-03-01', :last_day => '2021-03-07', :now_flag => 't', :api_id => 1326)
dob.tournament_years.create(:year => 2021, :first_day => '2021-03-14', :last_day => '2021-03-20', :now_flag => 't', :api_id => 1332)
meki.tournament_years.create(:year => 2021, :first_day => '2021-03-15', :last_day => '2021-03-20', :now_flag => 't', :api_id => 1333)
val.tournament_years.create(:year => 2021, :first_day => '2021-04-19', :last_day => '2021-04-25', :now_flag => 't', :api_id => 1339)
shin.tournament_years.create(:year => 2021, :first_day => '2021-06-14', :last_day => '2021-06-20', :now_flag => 't', :api_id => 1350)
nov.tournament_years.create(:year => 2021, :first_day => '2021-06-14', :last_day => '2021-06-20', :now_flag => 't', :api_id => 1351)
han.tournament_years.create(:year => 2021, :first_day => '2021-07-12', :last_day => '2021-07-18', :now_flag => 't', :api_id => 1356)
city.tournament_years.create(:year => 2021, :first_day => '2021-08-02', :last_day => '2021-08-08', :now_flag => 't', :api_id => 1364)
chi.tournament_years.create(:year => 2021, :first_day => '2021-10-04', :last_day => '2021-10-10', :now_flag => 't', :api_id => 1376)
tok.tournament_years.create(:year => 2021, :first_day => '2021-10-04', :last_day => '2021-10-10', :now_flag => 't', :api_id => 1375) 
el.tournament_years.create(:year => 2021, :first_day => '2021-10-25', :last_day => '2021-10-31', :now_flag => 't', :api_id => 1381)
ind.tournament_years.create(:year => 2021, :first_day => '2021-10-25', :last_day => '2021-10-31', :now_flag => 't', :api_id => 1382)
=end