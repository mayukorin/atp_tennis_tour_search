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
end
