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

=end

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

grand_slam.save
=begin
me << grand_slam
pa << grand_slam
lo << grand_slam
ny << grand_slam
=end
