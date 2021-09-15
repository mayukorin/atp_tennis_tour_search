class FavoritesController < ApplicationController
    def create
        player = Player.find(params[:favorite_player_id])
        current_user.make_favorite(player)
        redirect_to player
    end

    def destroy
        player = Favorite.find(params[:id]).player
        current_user.destroy_favorite(player)
        redirect_to player
    end
end
