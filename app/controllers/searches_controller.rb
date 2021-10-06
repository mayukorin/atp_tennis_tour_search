class SearchesController < ApplicationController

    def search
        @tournament = Tournament.find_by(name: params[:name])
        puts @tournament
        if @tournament
            redirect_to tournament_path(@tournament)
        end
        @player = Player.find_by(name: params[:name])
        if @player
            redirect_to player_path(@player)
        end
    end

end