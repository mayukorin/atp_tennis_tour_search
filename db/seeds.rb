# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# coding: utf-8

Tournament.create(:name => '全豪オープン', :abbreviation => 'ME', :city => 'メルボルン')
Tournament.create(:name => '全仏オープン', :abbreviation => 'PA', :city => 'パリ')
Tournament.create(:name => 'ウィンブルドン', :abbreviation => 'LO', :city => 'ロンドン')
Tournament.create(:name => '全米オープン', :abbreviation => 'NY', :city => 'ニューヨーク')

joko = Player.create(:name => 'ジョコビッチ')
nishi = Player.create(:name => '錦織圭')

tournament = Tournament.find_by(name: '全豪オープン')
me = tournament.tournament_years.create(:year => 2021, :first_day => '2021-02-08', :last_day => '2021-02-21', :now_flag => 't')


tournament = Tournament.find_by(name: '全仏オープン')
pa = tournament.tournament_years.create(:year => 2021, :first_day => '2021-05-30', :last_day => '2021-06-13', :now_flag => 't')

tournament = Tournament.find_by(name: 'ウィンブルドン')
lo = tournament.tournament_years.create(:year => 2021, :first_day => '2021-06-28', :last_day => '2021-07-11', :now_flag => 't')

tournament = Tournament.find_by(name: '全米オープン')
ny = tournament.tournament_years.create(:year => 2021, :first_day => '2021-08-30', :last_day => '2021-09-12', :now_flag => 't')

joko.my_champion_tournament_years << me
# joko.tournament_years << ny
joko.my_champion_tournament_years << pa
joko.my_champion_tournament_years << lo


TournamentYear.all.each do |tournament_year| 
    start_day = tournament_year.first_day
    end_day = tournament_year.last_day
    end_day += 1
    (start_day..end_day).each do |day|
        tournament_year.batch_schedules.create(:today => day)
    end
    tp1 = tournament_year.tournament_year_and_players.create(:remain_flag => 't')
    tp2 = tournament_year.tournament_year_and_players.create(:remain_flag => 'f')
    joko.tournament_year_and_players << tp1
    nishi.tournament_year_and_players << tp2

end

match1 = me.matches.create(:day => '2021-02-08')
match2 = me.matches.create(:day => '2021-02-10')


match3 = ny.matches.create(:day => '2021-08-31')
match4 = ny.matches.create(:day => '2021-09-01')
match5 = ny.matches.create(:day => '2021-09-03')
match6 = ny.matches.create(:day => '2021-09-05')


player_matches1 = match1.player_matches.create(:win_flag => 't')
joko.player_matches << player_matches1

player_matches2 = match1.player_matches.create(:win_flag => 'f')
nishi.player_matches << player_matches2

player_matches3 = match2.player_matches.create(:win_flag => 't')
joko.player_matches << player_matches3

player_matches4 = match2.player_matches.create(:win_flag => 'f')
nishi.player_matches << player_matches4

player_matches5 = match3.player_matches.create(:win_flag => 't')
joko.player_matches << player_matches5

player_matches6 = match3.player_matches.create(:win_flag => 'f')
nishi.player_matches << player_matches6

player_matches7 = match4.player_matches.create(:win_flag => 'f')
joko.player_matches << player_matches7

player_matches8 = match4.player_matches.create(:win_flag => 't')
nishi.player_matches << player_matches8

player_matches9 = match5.player_matches.create(:win_flag => 'f')
joko.player_matches << player_matches9

player_matches10 = match5.player_matches.create(:win_flag => 't')
nishi.player_matches << player_matches10

player_matches11 = match6.player_matches.create(:win_flag => 'f')
joko.player_matches << player_matches11

player_matches12 = match6.player_matches.create(:win_flag => 't')
nishi.player_matches << player_matches12