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




