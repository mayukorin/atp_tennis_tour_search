class FavoritesController < ApplicationController
    def create
        @player = Player.find(params[:favorite_player_id])
        current_user.make_favorite(@player)
        respond_to do |format|
            format.html { redirect_to @player }
            format.js
        end
    end

    def destroy
        @player = Favorite.find(params[:id]).player
        current_user.destroy_favorite(@player)
        respond_to do |format|
            format.html { redirect_to @player }
            format.js
        end
    end
end
