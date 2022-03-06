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


me = Tournament.find_by(name: '全豪オープン')
me.update(site_url: 'https://ausopen.com/')
pa = Tournament.find_by(name: '全仏オープン')
pa.update(site_url: 'https://www.rolandgarros.com/en-us/')
lo = Tournament.find_by(name: 'ウィンブルドン')
lo.update(site_url: 'https://www.wimbledon.com/')
ny = Tournament.find_by(name: '全米オープン')
ny.update(site_url: 'https://www.usopen.org/index.html')
my = Tournament.find_by(name: 'マイアミオープン')
my.update(site_url: 'https://www.miamiopen.com/')
lor = Tournament.find_by(name: 'ロレックス・モンテカルロ・マスターズ')
lor.update(site_url: 'https://montecarlotennismasters.com/')
mu = Tournament.find_by(name: 'ムチュア・マドリード・オープン')
mu.update(site_url: 'https://www.madrid-open.com/')
bnl = Tournament.find_by(name: 'BNLイタリア国際')
bnl.update(site_url: 'https://www.internazionalibnlditalia.com/')
na = Tournament.find_by(name: 'ナショナルバンク・オープン')
na.update(site_url: 'https://nationalbankopen.com/')
sa = Tournament.find_by(name: 'ウエスタン&サザン・オープン')
sa.update(site_url: 'https://www.wsopen.com/')
shy = Tournament.find_by(name: 'ロレックス上海マスターズ')
shy.update(site_url: 'https://en.rolexshanghaimasters.com/')
bnp = Tournament.find_by(name: 'BNPパリバ・オープン')
bnp.update(site_url: 'https://bnpparibasopen.com/')
lp = Tournament.find_by(name: 'ロレックス・パリ・マスターズ')
lp.update(site_url: 'https://www.rolexparismasters.com/')

abn = Tournament.find_by(name: 'ABNアムロ・ワールド・テニス・トーナメント')
abn.update(site_url: 'https://www.abnamrowtt.nl/')
dob = Tournament.find_by(name: 'ドバイ・デューティフリー・テニス選手権')
dob.update(site_url: 'https://dubaidutyfreetennischampionships.com/')
meki = Tournament.find_by(name: 'メキシコ・オープン')
meki.update(site_url: 'https://www.atptour.com/en/tournaments/acapulco/807/overview')
val = Tournament.find_by(name: 'バルセロナ・オープン')
val.update(site_url: 'https://www.barcelonaopenbancsabadell.com/en/home/')
shin = Tournament.find_by(name: 'シンチ選手権')
shin.update(site_url: 'https://www.lta.org.uk/major-tennis-events/british-major-events/cinch-championships/')
nov = Tournament.find_by(name: 'ノベンティ・オープン')
nov.update(site_url: 'https://www.noventi-open.de/en/')
han = Tournament.find_by(name: 'ハンブルク・ヨーロピアン・オープン')
han.update(site_url: 'https://www.atptour.com/en/tournaments/hamburg/414/overview')
city = Tournament.find_by(name: 'シティ・オープン')
city.update(site_url: 'https://www.citiopentennis.com/')
chi = Tournament.find_by(name: 'チャイナ・オープン')
chi.update(site_url: 'http://www.chinaopen.com/')
tok = Tournament.find_by(name: '楽天ジャパン・オープン')
tok.update(site_url: 'https://www.rakutenopen.com/')
el = Tournament.find_by(name: 'エルステ・バンク・オープン')
el.update(site_url: 'https://www.erstebank-open.com/')
ind = Tournament.find_by(name: 'スイス・インドア')
ind.update(site_url: 'https://www.swisessindoorsbasel.ch/')

me = TournamentYear.find(1)
me.create_batch_schedule(start_day: '2021-02-07', end_day: '2021-02-22', start_hour: 9)

=end

=begin
me = TournamentYear.find(2)
me.create_batch_schedule(start_day: '2021-05-29', end_day: '2021-06-14', start_hour: 18)

me = TournamentYear.find(3)
me.create_batch_schedule(start_day: '2021-06-27', end_day: '2021-07-12', start_hour: 19)

me = TournamentYear.find(4)
me.create_batch_schedule(start_day: '2021-08-29', end_day: '2021-09-12', start_hour: 0)

me = TournamentYear.find(5)
me.create_batch_schedule(start_day: '2021-03-23', end_day: '2021-04-04', start_hour: 0)

me = TournamentYear.find(6)
me.create_batch_schedule(start_day: '2021-04-10', end_day: '2021-04-19', start_hour: 18)

me = TournamentYear.find(7)
me.create_batch_schedule(start_day: '2021-05-01', end_day: '2021-05-10', start_hour: 18)

me = TournamentYear.find(8)
me.create_batch_schedule(start_day: '2021-05-08', end_day: '2021-05-17', start_hour: 18)

me = TournamentYear.find(9)
me.create_batch_schedule(start_day: '2021-08-08', end_day: '2021-08-15', start_hour: 0)

me = TournamentYear.find(10)
me.create_batch_schedule(start_day: '2021-08-14', end_day: '2021-08-22', start_hour: 0)

me = TournamentYear.find(11)
me.create_batch_schedule(start_day: '2021-10-02', end_day: '2021-10-11', start_hour: 12)

me = TournamentYear.find(12)
me.create_batch_schedule(start_day: '2021-10-06', end_day: '2021-10-17', start_hour: 3)

me = TournamentYear.find(13)
me.create_batch_schedule(start_day: '2021-10-31', end_day: '2021-11-07', start_hour: 0)

me = TournamentYear.find(14)
me.create_batch_schedule(start_day: '2021-02-28', end_day: '2021-03-08', start_hour: 18)

me = TournamentYear.find(15)
me.create_batch_schedule(start_day: '2021-03-13', end_day: '2021-03-21', start_hour: 16)

me = TournamentYear.find(16)
me.create_batch_schedule(start_day: '2021-03-14', end_day: '2021-03-20', start_hour: 1)

me = TournamentYear.find(17)
me.create_batch_schedule(start_day: '2021-04-18', end_day: '2021-04-26', start_hour: 18)

me = TournamentYear.find(18)
me.create_batch_schedule(start_day: '2021-06-13', end_day: '2021-06-21', start_hour: 19)

me = TournamentYear.find(19)
me.create_batch_schedule(start_day: '2021-06-13', end_day: '2021-06-21', start_hour: 18)

me = TournamentYear.find(20)
me.create_batch_schedule(start_day: '2021-07-11', end_day: '2021-07-19', start_hour: 18)

me = TournamentYear.find(21)
me.create_batch_schedule(start_day: '2021-08-01', end_day: '2021-08-08', start_hour: 0)

me = TournamentYear.find(22)
me.create_batch_schedule(start_day: '2021-10-03', end_day: '2021-10-11', start_hour: 12)

me = TournamentYear.find(23)
me.create_batch_schedule(start_day: '2021-10-03', end_day: '2021-10-11', start_hour: 11)

me = TournamentYear.find(24)
me.create_batch_schedule(start_day: '2021-10-24', end_day: '2021-11-01', start_hour: 18)

me = TournamentYear.find(25)
me.create_batch_schedule(start_day: '2021-10-24', end_day: '2021-11-01', start_hour: 18)


City.create!(name: 'ニューヨーク', latitude: '40.717079', longitude: '-74.00116')

ny = City.find_by(name: 'ニューヨーク')
Tournament.find_by(name: '全米オープン').update!(city_id: ny.id)

me = City.create!(name: 'メルボルン', latitude: '-37.814', longitude: '144.96332')
Tournament.find_by(name: '全豪オープン').update!(city_id: me.id)

pa = City.create!(name: 'パリ', latitude: '48.85341', longitude: '2.3488')
Tournament.find_by(name: '全仏オープン').update!(city_id: pa.id)
Tournament.find_by(name: 'ロレックス・パリ・マスターズ').update!(city_id: pa.id)

lo = City.create!(name: 'ロンドン', latitude: '51.3026', longitude: '0.0739')
Tournament.find_by(name: 'ウィンブルドン').update!(city_id: lo.id)
Tournament.find_by(name: 'シンチ選手権').update!(city_id: lo.id)

my = City.create!(name: 'マイアミ', latitude: '25.7616', longitude: '-80.1917')
Tournament.find_by(name: 'マイアミオープン').update!(city_id: my.id)

mo = City.create!(name: 'モンテカルロ', latitude: '43.4423', longitude: '7.2538')
Tournament.find_by(name: 'ロレックス・モンテカルロ・マスターズ').update!(city_id: mo.id)


ma = City.create!(name: 'マドリード', latitude: '40.4165', longitude: '-3.70256')
Tournament.find_by(name: 'ムチュア・マドリード・オープン').update!(city_id: ma.id)

lo = City.create!(name: 'ローマ', latitude: '41.89474', longitude: '12.4839')
Tournament.find_by(name: 'BNLイタリア国際').update!(city_id: lo.id)


to = City.create!(name: 'トロント', latitude: '43.7001', longitude: '-79.4163')
Tournament.find_by(name: 'ナショナルバンク・オープン').update!(city_id: to.id)

si = City.create!(name: 'シンシナティ', latitude: '39.162', longitude: '-84.45689')
Tournament.find_by(name: 'ウエスタン&サザン・オープン').update!(city_id: si.id)

shy = City.create!(name: '上海', latitude: '31.2333', longitude: '121.14651')
Tournament.find_by(name: 'ロレックス上海マスターズ').update!(city_id: shy.id)

ind = City.create!(name: 'インディアンウェルズ', latitude: '35.6652', longitude: '-117.8731')
Tournament.find_by(name: 'BNPパリバ・オープン').update!(city_id: ind.id)

am = City.create!(name: 'ロッテルダム', latitude: '48.85341', longitude: '2.3488')
Tournament.find_by(name: 'ABNアムロ・ワールド・テニス・トーナメント').update!(city_id: am.id)


doo = City.create!(name: 'ドバイ', latitude: '25.2048', longitude: '55.2707')
Tournament.find_by(name: 'ドバイ・デューティフリー・テニス選手権').update!(city_id: doo.id)

aka = City.create!(name: 'アカプルコ', latitude: '16.8638', longitude: '-99.88')
Tournament.find_by(name: 'メキシコ・オープン').update!(city_id: aka.id)

val = City.create!(name: 'バルセロナ', latitude: '41.385', longitude: '2.1734')
Tournament.find_by(name: 'バルセロナ・オープン').update!(city_id: val.id)

val = City.create!(name: 'ハレ', latitude: '51.28', longitude: '11.58')
Tournament.find_by(name: 'ノベンティ・オープン').update!(city_id: val.id)

val = City.create!(name: 'ハンブルク', latitude: '53.38', longitude: '10.00')
Tournament.find_by(name: 'ハンブルク・ヨーロピアン・オープン').update!(city_id: val.id)

val = City.create!(name: 'ワシントンD.C.', latitude: '38.9041', longitude: '-77.0171')
Tournament.find_by(name: 'シティ・オープン').update!(city_id: val.id)

val = City.create!(name: '北京', latitude: '39.54', longitude: '116.24')
Tournament.find_by(name: 'チャイナ・オープン').update!(city_id: val.id)

val = City.create!(name: '東京', latitude: '35.39', longitude: '139.32')
Tournament.find_by(name: '楽天ジャパン・オープン').update!(city_id: val.id)

val = City.create!(name: 'ウィーン', latitude: '48.13', longitude: '16.22')
Tournament.find_by(name: 'エルステ・バンク・オープン').update!(city_id: val.id)

val = City.create!(name: 'バーゼル', latitude: '47.34', longitude: '7.36')
Tournament.find_by(name: 'スイス・インドア').update!(city_id: val.id)
=end
# newnew
me = Tournament.find_by(name: '全豪オープン')
me2 = me.tournament_years.create!(:year => 2022, :first_day => '2022-01-17', :last_day => '2022-01-30', :now_flag => 't', :api_id => 1437)
me2.create_batch_schedule(start_day: '2022-01-16', end_day: '2022-01-31', start_hour: 9)


pa = Tournament.find_by(name: '全仏オープン')
pa2 = pa.tournament_years.create(:year => 2022, :first_day => '2022-05-22', :last_day => '2022-06-05', :now_flag => 't', :api_id => 1464)
pa2.create_batch_schedule(start_day: '2022-05-21', end_day: '2022-06-06', start_hour: 18)

lo = Tournament.find_by(name: 'ウィンブルドン')
lo2 = lo.tournament_years.create(:year => 2022, :first_day => '2022-06-27', :last_day => '2022-07-10', :now_flag => 't', :api_id => 1471)
lo2.create_batch_schedule(start_day: '2022-06-26', end_day: '2022-07-11', start_hour: 19)

my = Tournament.find_by(name: 'マイアミオープン')
my2 = my.tournament_years.create(:year => 2022, :first_day => '2022-03-23', :last_day => '2022-04-03', :now_flag => 't', :api_id => 1452)
my2.create_batch_schedule(start_day: '2022-03-23', end_day: '2022-04-03', start_hour: 0)

lor = Tournament.find_by(name: 'ロレックス・モンテカルロ・マスターズ')
lor2 = lor.tournament_years.create(:year => 2022, :first_day => '2022-04-10', :last_day => '2022-04-17', :now_flag => 't', :api_id => 1455)
lor2.create_batch_schedule(start_day: '2022-04-09', end_day: '2022-04-18', start_hour: 18)

mu = Tournament.find_by(name: 'ムチュア・マドリード・オープン')
mu2 = mu.tournament_years.create(:year => 2022, :first_day => '2022-05-01', :last_day => '2022-05-08', :now_flag => 't', :api_id => 1460)
mu2.create_batch_schedule(start_day: '2022-04-29', end_day: '2022-05-09', start_hour: 18)

bnl = Tournament.find_by(name: 'BNLイタリア国際')
bnl2 = bnl.tournament_years.create(:year => 2022, :first_day => '2022-05-08', :last_day => '2022-05-15', :now_flag => 't', :api_id => 1461)
bnl2.create_batch_schedule(start_day: '2022-05-07', end_day: '2022-05-16', start_hour: 18)

abn = Tournament.find_by(name: 'ABNアムロ・ワールド・テニス・トーナメント')
abn2 = abn.tournament_years.create(:year => 2022, :first_day => '2022-02-07', :last_day => '2022-02-13', :now_flag => 't', :api_id => 1441)
abn2.create_batch_schedule(start_day: '2022-02-06', end_day: '2022-02-14', start_hour: 18)

dob = Tournament.find_by(name: 'ドバイ・デューティフリー・テニス選手権')
dob2 = dob.tournament_years.create(:year => 2022, :first_day => '2022-02-21', :last_day => '2022-02-26', :now_flag => 't', :api_id => 1450)
dob2.create_batch_schedule(start_day: '2022-02-20', end_day: '2022-02-27', start_hour: 16)

meki = Tournament.find_by(name: 'メキシコ・オープン')
meki2 = meki.tournament_years.create(:year => 2022, :first_day => '2022-02-21', :last_day => '2022-02-26', :now_flag => 't', :api_id => 1448)
meki2.create_batch_schedule(start_day: '2022-02-21', end_day: '2022-02-21', start_hour: 1)

val = Tournament.find_by(name: 'バルセロナ・オープン')
val2 = val.tournament_years.create(:year => 2022, :first_day => '2022-04-18', :last_day => '2022-04-24', :now_flag => 't', :api_id => 1456)
val2.create_batch_schedule(start_day: '2022-04-17', end_day: '2022-04-25', start_hour: 18)

shin = Tournament.find_by(name: 'シンチ選手権')
shin2 = shin.tournament_years.create(:year => 2022, :first_day => '2022-06-13', :last_day => '2022-06-19', :now_flag => 't', :api_id => 1467)
shin2.create_batch_schedule(start_day: '2022-06-12', end_day: '2022-06-20', start_hour: 19)

# 2021 のtyをnow flag falseに
TournamentYear.where(year: 2021).update_all(now_flag: 'f')
# リオオープンなど，新しく 500 になったもの

tournament_years_2021 = TournamentYear.where(year: 2021)

tournament_years_2021.each do |tournament_year|
    tournament_year_2022_cnt = TournamentYear.where(year: 2022, tournament_id: tournament_year.tournament.id).count()
    if tournament_year_2022_cnt == 0
        tournament_year.update(now_flag: 't')
    end

end
