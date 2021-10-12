class SearchesController < ApplicationController

    def search
        @tournament = Tournament.find_by(name: params[:name])
        if @tournament
            redirect_to tournament_path(@tournament)
        end
        @player = Player.find_by(name: params[:name])
        if @player
            redirect_to player_path(@player)
        end
        flash[:danger] = "検索結果が見つかりませんでした"
        redirect_to(params[:back_url])
    end

end