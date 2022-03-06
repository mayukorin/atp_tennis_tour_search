class SearchesController < ApplicationController

    def search

        @tournament = Tournament.find_by(name: params[:name])
        redirect_to tournament_path(@tournament) and return if @tournament

        @player = Player.find_by(name: params[:name])
        @player ||= Player.find_by(full_name: params[:name])
        redirect_to player_path(@player) and return if @player
        
        flash[:danger] = "検索結果が見つかりませんでした"
        redirect_to(params[:back_url])
    end

    def get_search_candidates
        tournaments = Tournament.where("name LIKE ?", params[:name]+"%")
        players = Player.where("name LIKE ?", params[:name]+"%")
        full_name_players = Player.where("full_name LIKE ?", params[:name]+"%")
        render json: { tournaments: tournaments, players: players, full_name_players: full_name_players }
    end

end