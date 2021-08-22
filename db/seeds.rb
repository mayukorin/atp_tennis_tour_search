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
    tp1 = tournament_year.tournament_year_and_players.create(:win_flag => 't')
    tp2 = tournament_year.tournament_year_and_players.create(:win_flag => 'f')
    joko.tournament_year_and_players << tp1
    nishi.tournament_year_and_players << tp2

end

match1 = me.matches.create(:day => '2021-02-08')
match2 = me.matches.create(:day => '2021-02-10')

joko.player1_mathes << match1
nishi.player2_mathes << match1

joko.player1_mathes << match2
nishi.player2_mathes << match2

match3 = ny.matches.create(:day => '2021-08-31')
match4 = ny.matches.create(:day => '2021-09-01')

joko.player1_mathes << match3
nishi.player2_mathes << match3

joko.player1_mathes << match4
nishi.player2_mathes << match4

nishi.win_mathes << match3