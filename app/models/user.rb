class User < ApplicationRecord
    before_save { self.email = email.downcase }
    has_many :favorites
    has_many :favorite_players, class_name: 'Player', through: :favorites, source: :player
    validates :name, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    # 文字列の上限は 255
    validates :email, presence: true, length: { maximum: 255 },
                      format: { with: VALID_EMAIL_REGEX },
                      uniqueness: true
    validates :password, presence: true, length: { minimum: 6 }
    has_secure_password

    def make_favorite(player)
        favorite_players << player
    end

    def favorite?(player)
        favorite_players.include?(player)
    end

    def destroy_favorite(player)
        favorites.find_by(player_id: player.id).destroy
    end

    def favorite_players_id_list
        id_list = []
        favorite_players.each do |favorite_player|
            id_list.push(favorite_player.id)
        end
        return id_list
    end

    def get_favorite_player_and_recently_matches
        @player_ids_and_latest_match_days = PlayerMatch.joins(:match).select("player_id, max(matches.day) as md").group(:player_id).to_sql
        @latest_player_matches_and_matches_ids =  PlayerMatch.select("player_matches.id, player_matches.match_id").joins("INNER JOIN matches as bb ON player_matches.match_id=bb.id").joins("INNER JOIN (#{@player_ids_and_latest_match_days}) as aa ON player_matches.player_id=aa.player_id").where("aa.md = bb.day")
        @player_ids_and_second_latest_match_days = PlayerMatch.joins(:match).select("player_id, max(matches.day) as md").where("matches.id not in (?)", @latest_player_matches_and_matches_ids.pluck("player_matches.match_id")).group(:player_id).to_sql
        @second_latest_player_matches_ids =  PlayerMatch.joins("INNER JOIN matches as bb ON player_matches.match_id=bb.id").joins("INNER JOIN (#{@player_ids_and_second_latest_match_days}) as aa ON player_matches.player_id=aa.player_id").where("aa.md = bb.day").pluck("player_matches.id")
        return favorite_players.eager_loading.where("player_matches.id in (?)", @latest_player_matches_and_matches_ids.pluck("player_matches.id")+@second_latest_player_matches_ids)
    end
end
