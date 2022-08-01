class PlayerMatch < ApplicationRecord
  belongs_to :player
  belongs_to :match
  belongs_to :recently_match, class_name: 'Match', :foreign_key => 'match_id'
  scope :eager_loading, -> { eager_load(:player, match: [{tournament_year: :tournament}, :home_player, :away_player, :win_player]) }
  scope :in_order_of_latest, -> { order("matches.day desc") }
  scope :search_by_player_and_tournament_year, -> (player_id, tournament_year_id ) { where(player: player_id, matches: {tournament_year: tournament_year_id }) }
  
  def self.get_latest_and_second_player_matches_ids_per_players
    @player_ids_and_latest_match_days = PlayerMatch.joins(:match).select("player_id, max(matches.day) as latest_match_day").group(:player_id).to_sql
    @latest_player_matches_and_matches_ids =  PlayerMatch.joins(:match).select("player_matches.id, player_matches.match_id").joins("INNER JOIN (#{@player_ids_and_latest_match_days}) as pilmd ON player_matches.player_id=pilmd.player_id AND pilmd.latest_match_day = matches_player_matches.day")
    
    @player_ids_and_second_latest_match_days = PlayerMatch.joins(:match).select("player_id, max(matches.day) as second_latest_match_day").where("matches.id not in (?)", @latest_player_matches_and_matches_ids.pluck("player_matches.match_id")).group(:player_id).to_sql
    @second_latest_player_matches_ids =  PlayerMatch.joins(:match).joins("INNER JOIN (#{@player_ids_and_second_latest_match_days}) as pislmd ON player_matches.player_id=pislmd.player_id AND matches_player_matches.day = pislmd.second_latest_match_day")
    
    latest_and_second_player_matches_id_per_players = @latest_player_matches_and_matches_ids.pluck("player_matches.id")+@second_latest_player_matches_ids.pluck("player_matches.id")
  end
end
