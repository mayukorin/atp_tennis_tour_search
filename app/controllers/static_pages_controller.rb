class StaticPagesController < ApplicationController
  def home
    @msg = "worldd"
  end

  def get_tournament_info
    tournament_info = {id: 1}
    render json: tournament_info
end
