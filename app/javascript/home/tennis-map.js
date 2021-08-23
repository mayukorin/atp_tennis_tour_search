
$(function () {
    $.ajax({
        type: "GET",
        url: "/get_tournament_info",
        dataType: "json"
    }).done(function(res){
        console.log(res);
        /*
        let contents = new Map();
        for(var key in res) {
            var contentAndColor = new Map();
            var tournament_name = res[key]["name"];
            var city_name = res[key]["city"];
            var period = res[key]["period"];
            var content =  `<div>`+
                           `<div>${tournament_name}</div>`+
                           `<div>開催都市 : ${city_name}</div>`+
                           `<div>開催期間 : ${period}</div>`;

            if (res[key]["now_flag"] == 0) {
                var champion = res[key]["champion"];
                content += `<div>優勝者 : ${champion}`+
                           `</div>`;
                contentAndColor.set("plotColor", "blue");
            } else {
                var main_players = ``;
                for(var id in res[key]["main_players"]) {
                    var player = res[key]["main_players"][id]["name"];
                    if (res[key]["main_players"][id]["win_flag"] == 1) {
                        main_players += `<span>${player}</span> `;
                    } else {
                        main_players += `<span style=\"color: #EEEEEE;\">${player} </span> `;
                    }
                }
                content +=  '<div>主な出場者:</div>'+
                            `${main_players}`+
                            '</div>';
                contentAndColor.set("plotColor", "red");
            }
            contentAndColor.set("content", content);
            contents.set(key, contentAndColor);
        }
        */
        /*
        let contentForME =  "<div>"+
                            "<div>全豪オープン</div>"+
                            "<div>開催都市 : メルボルン</div>"+
                            "<div>開催期間 : 2/11 ~ 2/22</div>"+
                            "<div>優勝者 : N.ジョコビッチ"+
                            "</div>";
        let contentForNY =  "<div>"+
                            "<div>全米オープン</div>"+
                            "<div>開催都市 : ニューヨーク</div>"+
                            "<div>開催期間 : 8/11 ~ 8/22</div>"+
                            "<div>主な出場者 : </div>"+
                            "<div>N.ジョコビッチ <span style=\"color: #EEEEEE;\">A.マクドナルド</span> A.ああああああ</div>"
                            "</div>";
        contents.set("ME", contentForME);
        contents.set("NY", contentForNY);
        */
       /*
        $(".map_container").mapael({
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
                    tooltip: {content: contents.get("NY").get("content"), cssClass: "tournament_explain"},
                    href: "/",
                    size: 10,
                    attrs: {
                        fill: contents.get("NY").get("plotColor")
                    }
                }, 
                'me': {
                    latitude: -37.814,
                    longitude: 144.96332,
                    tooltip: {content: contents.get("ME").get("content")},
                    href: "/",
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
        */

    }).fail(function() {
        alert(error);
    })
});


