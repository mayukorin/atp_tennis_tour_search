# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# coding: utf-8

Tournament.create(:name => '全豪オープン')
Tournament.create(:name => '全仏オープン')
Tournament.create(:name => 'ウィンブルドン')
Tournament.create(:name => '全米オープン')

tournament = Tournament.find_by(name: '全豪オープン')
tournament.tournament_years.create(:year => 2021, :first_day => '2021-02-08', :last_day => '2021-02-21')

tournament = Tournament.find_by(name: '全仏オープン')
tournament.tournament_years.create(:year => 2021, :first_day => '2021-05-30', :last_day => '2021-06-13')

tournament = Tournament.find_by(name: 'ウィンブルドン')
tournament.tournament_years.create(:year => 2021, :first_day => '2021-06-28', :last_day => '2021-07-11')

tournament = Tournament.find_by(name: '全米オープン')
tournament.tournament_years.create(:year => 2021, :first_day => '2021-08-30', :last_day => '2021-09-12')

TournamentYear.all.each do |tournament_year| 
    start_day = tournament_year.first_day
    end_day = tournament_year.last_day
    end_day += 1
    (start_day..end_day).each do |day|
        tournament_year.batch_schedules.create(:today => day)
    end
end