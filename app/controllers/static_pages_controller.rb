class StaticPagesController < ApplicationController
  def home
    @msg = "worldd"
  end

  def get_tournament_info
    tournament_info = { ME: {now_flag: 0, name: '全豪オープン', city: 'メルボルン', period: '2/11~2/22', champion: 'N ジョコビッチ'}, 
                        NY: {now_flag: 1, name: '全米オープン', city: 'ニューヨーク', period: '8/11=8/22', champion: '',
                            main_players: {
                             2 => {name: 'ジョコビッチ', flag: 0},
                             1 => {name: '錦織圭', flag: 1}
                            }
                            }
                      }
      
    render json: tournament_info
  end
end
