class Match < ApplicationRecord
  belongs_to :tournament_year
  belongs_to :player1, class_name: 'Player', :foreign_key => 'player1_id'
  belongs_to :player2, class_name: 'Player', :foreign_key => 'player2_id'
  belongs_to :win_player, optional: true, class_name: 'Player', :foreign_key => 'win_player_id'
  has_many :player_matches
  has_many :players, through: :player_matches
end
