# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# coding: utf-8
ue = Tournament.create(:name => 'ウィンストン・セーラム', :abbreviation => 'UE', :city => 'ウィンストン・セーラム')
uey = ue.tournament_years.create(:year => 2021, :first_day => '2021-08-22', :last_day => '2021-08-28', :now_flag => 't', :api_id => 1367)


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
me_joko_tp = TournamentYearAndPlayer.create(:tournament_year_id => me.id, :player_id => joko.id, :remain_flag => 't')
me_nishi_tp = TournamentYearAndPlayer.create(:tournament_year_id => me.id, :player_id => nishi.id, :remain_flag => 'f')
ny_joko_tp = TournamentYearAndPlayer.create(:tournament_year_id => ny.id, :player_id => joko.id, :remain_flag => 't')
ny_nishi_tp = TournamentYearAndPlayer.create(:tournament_year_id => ny.id, :player_id => nishi.id, :remain_flag => 't')

match1 = me.matches.create(:day => '2021-02-08', :home_player_id => nishi.id, :away_player_id => joko.id, :win_player_id => joko.id)
match2 = me.matches.create(:day => '2021-02-10', :home_player_id => nishi.id, :away_player_id => joko.id, :win_player_id => joko.id)


match3 = ny.matches.create(:day => '2021-08-31', :home_player_id => nishi.id, :away_player_id => joko.id, :win_player_id => joko.id)
match4 = ny.matches.create(:day => '2021-09-01', :home_player_id => nishi.id, :away_player_id => joko.id, :win_player_id => nishi.id)
match5 = ny.matches.create(:day => '2021-09-03')
match6 = ny.matches.create(:day => '2021-09-05')

TourPlayerMatch.create(:match_id => match1.id, :tournament_year_and_player_id => me_joko_tp.id)
TourPlayerMatch.create(:match_id => match1.id, :tournament_year_and_player_id => me_nishi_tp.id)

TourPlayerMatch.create(:match_id => match2.id, :tournament_year_and_player_id => ny_joko_tp.id)
TourPlayerMatch.create(:match_id => match2.id, :tournament_year_and_player_id => ny_nishi_tp.id)

TourPlayerMatch.create(:match_id => match3.id, :tournament_year_and_player_id => ny_joko_tp.id)
TourPlayerMatch.create(:match_id => match3.id, :tournament_year_and_player_id => ny_nishi_tp.id)

TourPlayerMatch.create(:match_id => match4.id, :tournament_year_and_player_id => ny_joko_tp.id)
TourPlayerMatch.create(:match_id => match4.id, :tournament_year_and_player_id => ny_nishi_tp.id)

TourPlayerMatch.create(:match_id => match5.id, :tournament_year_and_player_id => ny_joko_tp.id)
TourPlayerMatch.create(:match_id => match5.id, :tournament_year_and_player_id => ny_nishi_tp.id)

TourPlayerMatch.create(:match_id => match6.id, :tournament_year_and_player_id => ny_joko_tp.id)
TourPlayerMatch.create(:match_id => match6.id, :tournament_year_and_player_id => ny_nishi_tp.id)