
$(function () {
    $.ajax({
        type: "GET",
        url: "/get_tournament_info",
        dataType: "json"
    }).done(function(response){
        console.log(response);
        let contents = new Map();
        let now_tournaments_name = "";
        for(var key in response) {
            var contentAndColor = new Map();
            var tournament_name = response[key]["tournament"]["name"];
            var city_name = response[key]["tournament"]["city"];
            var period = response[key]["period"];
            var content =  `<div>`+
                           `<div>${tournament_name}</div>`+
                           `<div>開催都市 : ${city_name}</div>`+
                           `<div>開催期間 : ${period}</div>`;
            contentAndColor.set("id", response[key]["id"])
            if (response[key]["champion"] != null) {
                var champion_name = response[key]["champion"]["name"];
                content += `<div>優勝者 : ${champion_name}`+
                           `</div>`;
                contentAndColor.set("plotColor", "blue");
            } else {
                var main_players = ``;
                for(var id in response[key]["tournament_year_and_players"]) {
                    var player_name = response[key]["tournament_year_and_players"][id]["player"]["name"];
                    if (response[key]["tournament_year_and_players"][id]["remain_flag"]) {
                        main_players += `<span>${player_name}</span> `;
                    } else {
                        main_players += `<span style=\"color: #EEEEEE;\">${player_name} </span> `;
                    }
                }
                content +=  '<div>主な出場者:</div>'+
                            `${main_players}`+
                            '</div>';
                contentAndColor.set("plotColor", "red");
                now_tournaments_name += tournament_name + " ";
            }
            contentAndColor.set("content", content);
            contents.set(response[key]["tournament"]["abbreviation"], contentAndColor);
        }
        if (now_tournaments_name != "") {
            $("#now-tournament-info").html(`現在 <span class="text-danger">${now_tournaments_name} </span>が開催中です`);
        } else {
            $("#now-tournament-info").html(`現在開催中の大会はありません`);
        }
        
        $(".map-container").mapael({
            map : {
                name : "world_countries",
                defaultArea: {
                    attrs: {
                        // 世界地図の国の色や境界
                        fill: "#f4f4e8",
                        stroke: "#ced8d0"
                    },
                    attrsHover: {
                        // 国をホバーした時
                        fill: "#f4f4e8",
                        stroke: "#f4f4e8",
                    }
                }
            },
            plots: {
                'ny': {
                    latitude: 40.717079,
                    longitude: -74.00116,
                    tooltip: {content: contents.get("NY").get("content")},
                    href: `/tournament_years/${contents.get("NY").get("id")}`,
                    size: 10,
                    attrs: {
                        fill: contents.get("NY").get("plotColor")
                    }
                }, 
                'me': {
                    latitude: -37.814,
                    longitude: 144.96332,
                    tooltip: {content: contents.get("ME").get("content")},
                    href: `/tournament_years/${contents.get("ME").get("id")}`,
                    size: 10,
                }, 
                'pa': {
                    latitude: 48.85341,
                    longitude: 2.3488,
                    tooltip: {content: "Pari"},
                    href: "/",
                    size: 10,
                },
                'lo': {
                    latitude: 51.3026,
                    longitude: 0.0739,
                    tooltip: {content: "London"},
                    href: "/",
                    size: 10,
                }
            }
        });
        

    }).fail(function() {
        alert(error);
    })
});


