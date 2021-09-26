class Tournament < ApplicationRecord
    has_many :tournament_years
    belongs_to :atp_category
end
