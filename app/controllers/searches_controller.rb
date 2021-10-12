class SearchesController < ApplicationController

    def search
        puts params[:name]
        puts "okkkkkk"
        @tournament = Tournament.find_by(name: params[:name])
        if @tournament
            puts "wwww"
            redirect_to tournament_path(@tournament) and return
        end
        @player = Player.find_by(name: params[:name])
        if @player
            redirect_to player_path(@player) and return
        end
        flash[:danger] = "検索結果が見つかりませんでした"
        redirect_to(params[:back_url])
    end

end