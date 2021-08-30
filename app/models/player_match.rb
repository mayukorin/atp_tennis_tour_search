class PlayerMatch < ApplicationRecord
  belongs_to :player
  belongs_to :match
  belongs_to :newer_match, class_name: 'Match', :foreign_key => 'match_id'
end
