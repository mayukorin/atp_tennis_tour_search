module ApplicationHelper
    def match_detail_url_of_google(match)
        "https://www.google.com/search?q=#{match.home_player.name}+#{match.away_player.name}+#{l match.day, format: :date_only}"
    end
end
