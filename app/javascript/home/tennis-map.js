$(document).on('turbolinks:load', function() {
        $.ajax({
            type: "GET",
            url: "/get_tournament_info",
            dataType: "json"
        }).done(function(response){
            console.log(response);
            let contents = new Map();
            contents["GRAND SLAM"] = new Map();
            contents["Masters 1000"] = new Map();
            contents["ATP 500"] = new Map();
            let now_tournaments_name = "";
            for(var key in response) {
                var contentAndColor = new Map();
                var atp_category_name = response[key]["tournament"]["atp_category"]["name"]
                var tournament_name = response[key]["tournament"]["name"];
                var city_name = response[key]["tournament"]["city"]["name"];
                var period = response[key]["period"];
                var content =  `<div>`+
                               `<div>${tournament_name}</div>`+
                               `<div>開催都市 : ${city_name}</div>`+
                               `<div>開催期間 : ${period}</div>`;
                contentAndColor.set("id", response[key]["tournament"]["id"])
                if (response[key]["hold_flag"]) {
                    contentAndColor.set("plotColor", "red");
                    now_tournaments_name += tournament_name + " ";
                } else {
                    contentAndColor.set("plotColor", "blue");
                }
                if (response[key]["champion"] != null) {
                    var champion_name = response[key]["champion"]["name"];
                    content += `<div>優勝者 : ${champion_name}`+
                               `</div>`;
                } else {
                    var main_players = ``;
                    for(var id in response[key]["top_ten_remain_players"]) {
                        var player_name = response[key]["top_ten_remain_players"][id]["name"];
                        main_players += `<span>${player_name}</span> `;
                    }
                    content +=  '<div>主な出場者:</div>'+
                                `${main_players}`+
                                '</div>';
                }
                contentAndColor.set("content", content);
                // contentAndColor.set("la", content);
     
                contents[atp_category_name].set(response[key]["tournament"]["abbreviation"], contentAndColor);
            }
            let map_info = `<div id="now-tournament-info" class="text-center mb-5"></div>
                            <div class="map-container-GRAND-SLAM">
                                <div class="text-success text-center m-5">
                                    <h2>GRAND SLAM</h2>
                                </div>
                                <div class="map"></div>
                            </div>
                            <div class="map-container-Masters-1000">
                                <div class="text-success text-center m-5">
                                    <h2>Masters 1000</h2>
                                </div>
                                <div class="map"></div>
                            </div>
                            <div class="map-container-ATP-500">
                                <div class="text-success text-center m-5">
                                    <h2>ATP 500</h2>
                                </div>
                                <div class="map"></div>
                            </div>`;
            $("#map-info").html(map_info)

        
            if (now_tournaments_name != "") {
                $("#now-tournament-info").html(`現在 <span class="text-danger">${now_tournaments_name} </span>が開催中です`);
            } else {
                $("#now-tournament-info").html(`現在開催中の大会はありません`);
            }
            
            $(".map-container-GRAND-SLAM").mapael({
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
                            stroke: "#ced8d0",
                        }
                    }
                },
                plots: {
                    'ny': {
                        latitude: 40.717079,
                        longitude: -74.00116,
                        tooltip: {content: contents["GRAND SLAM"].get("NY").get("content")},
                        href: `/tournaments/${contents["GRAND SLAM"].get("NY").get("id")}`,
                        size: 10,
                        attrs: {
                            fill: contents["GRAND SLAM"].get("NY").get("plotColor")
                        }
                    }, 
                    'me': {
                        latitude: -37.814,
                        longitude: 144.96332,
                        tooltip: {content: contents["GRAND SLAM"].get("ME").get("content")},
                        href: `/tournaments/${contents["GRAND SLAM"].get("ME").get("id")}`,
                        size: 10,
                        attrs: {
                            fill: contents["GRAND SLAM"].get("ME").get("plotColor")
                        }
                    }, 
                    'pa': {
                        latitude: 48.85341,
                        longitude: 2.3488,
                        tooltip: {content: contents["GRAND SLAM"].get("PA").get("content")},
                        href: `/tournaments/${contents["GRAND SLAM"].get("PA").get("id")}`,
                        size: 10,
                        attrs: {
                            fill: contents["GRAND SLAM"].get("PA").get("plotColor")
                        }
                    },
                    'lo': {
                        latitude: 51.3026,
                        longitude: 0.0739,
                        tooltip: {content: contents["GRAND SLAM"].get("LO").get("content")},
                        href: `/tournaments/${contents["GRAND SLAM"].get("LO").get("id")}`,
                        size: 10,
                        attrs: {
                            fill: contents["GRAND SLAM"].get("LO").get("plotColor")
                        }
                    }
                }
            });
    
            $(".map-container-Masters-1000").mapael({
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
                            stroke: "#ced8d0",
                        }
                    }
                },
                plots: {
                    'my': {
                        latitude: 25.7616,
                        longitude: -80.1917,
                        tooltip: {content: contents["Masters 1000"].get("MY").get("content")},
                        href: `/tournaments/${contents["Masters 1000"].get("MY").get("id")}`,
                        size: 10,
                        attrs: {
                            fill: contents["Masters 1000"].get("MY").get("plotColor")
                        }
                    }, 
                    'lor': {
                        latitude: 43.4423,
                        longitude: 7.2538,
                        tooltip: {content: contents["Masters 1000"].get("LOR").get("content")},
                        href: `/tournaments/${contents["Masters 1000"].get("LOR").get("id")}`,
                        size: 10,
                        attrs: {
                            fill: contents["Masters 1000"].get("LOR").get("plotColor")
                        }
                    }, 
                    'mu': {
                        latitude: 40.4165,
                        longitude: -3.70256,
                        tooltip: {content: contents["Masters 1000"].get("MU").get("content")},
                        href: `/tournaments/${contents["Masters 1000"].get("MU").get("id")}`,
                        size: 10,
                        attrs: {
                            fill: contents["Masters 1000"].get("MU").get("plotColor")
                        }
                    },
                    'bnl': {
                        latitude: 41.89474,
                        longitude: 12.4839,
                        tooltip: {content: contents["Masters 1000"].get("BNL").get("content")},
                        href: `/tournaments/${contents["Masters 1000"].get("BNL").get("id")}`,
                        size: 10,
                        attrs: {
                            fill: contents["Masters 1000"].get("BNL").get("plotColor")
                        }
                    },
                    'na': {
                        latitude: 43.7001,
                        longitude: -79.4163,
                        tooltip: {content: contents["Masters 1000"].get("NA").get("content")},
                        href: `/tournaments/${contents["Masters 1000"].get("NA").get("id")}`,
                        size: 10,
                        attrs: {
                            fill: contents["Masters 1000"].get("NA").get("plotColor")
                        }
                    },
                    'sa': {
                        latitude: 39.162,
                        longitude: -84.45689,
                        tooltip: {content: contents["Masters 1000"].get("SA").get("content")},
                        href: `/tournaments/${contents["Masters 1000"].get("SA").get("id")}`,
                        size: 10,
                        attrs: {
                            fill: contents["Masters 1000"].get("SA").get("plotColor")
                        }
                    },
                    'shy': {
                        latitude: 31.2333,
                        longitude: 121.14651,
                        tooltip: {content: contents["Masters 1000"].get("SHY").get("content")},
                        href: `/tournaments/${contents["Masters 1000"].get("SHY").get("id")}`,
                        size: 10,
                        attrs: {
                            fill: contents["Masters 1000"].get("SHY").get("plotColor")
                        }
                    },
                    'bnp': {
                        latitude: 35.6652,
                        longitude: -117.8731,
                        tooltip: {content: contents["Masters 1000"].get("BNP").get("content")},
                        href: `/tournaments/${contents["Masters 1000"].get("BNP").get("id")}`,
                        size: 10,
                        attrs: {
                            fill: contents["Masters 1000"].get("BNP").get("plotColor")
                        }
                    },
                    'lp': {
                        latitude: 48.85341,
                        longitude: 2.3488,
                        tooltip: {content: contents["Masters 1000"].get("LP").get("content")},
                        href: `/tournaments/${contents["Masters 1000"].get("LP").get("id")}`,
                        size: 10,
                        attrs: {
                            fill: contents["Masters 1000"].get("LP").get("plotColor")
                        }
                    }
                }
            });
    
            $(".map-container-ATP-500").mapael({
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
                            stroke: "#ced8d0",
                        }
                    }
                },
                plots: {
                    'abn': {
                        latitude: 51.9166,
                        longitude: 4.4667,
                        tooltip: {content: contents["ATP 500"].get("ABN").get("content")},
                        href: `/tournaments/${contents["ATP 500"].get("ABN").get("id")}`,
                        size: 10,
                        attrs: {
                            fill: contents["ATP 500"].get("ABN").get("plotColor")
                        }
                    },
                    'do': {
                        latitude: 25.2048,
                        longitude: 55.2707,
                        tooltip: {content: contents["ATP 500"].get("DO").get("content")},
                        href: `/tournaments/${contents["ATP 500"].get("DO").get("id")}`,
                        size: 10,
                        attrs: {
                            fill: contents["ATP 500"].get("DO").get("plotColor")
                        }
                    },
                    'meki': {
                        latitude: 16.8638,
                        longitude: -99.88,
                        tooltip: {content: contents["ATP 500"].get("MEKI").get("content")},
                        href: `/tournaments/${contents["ATP 500"].get("MEKI").get("id")}`,
                        size: 10,
                        attrs: {
                            fill: contents["ATP 500"].get("MEKI").get("plotColor")
                        }
                    },
                    'val': {
                        latitude: 41.385,
                        longitude: 2.1734,
                        tooltip: {content: contents["ATP 500"].get("VAL").get("content")},
                        href: `/tournaments/${contents["ATP 500"].get("VAL").get("id")}`,
                        size: 10,
                        attrs: {
                            fill: contents["ATP 500"].get("VAL").get("plotColor")
                        }
                    },
                    'shin': {
                        latitude: 51.3026,
                        longitude: 0.0739,
                        tooltip: {content: contents["ATP 500"].get("SHIN").get("content")},
                        href: `/tournaments/${contents["ATP 500"].get("SHIN").get("id")}`,
                        size: 10,
                        attrs: {
                            fill: contents["ATP 500"].get("SHIN").get("plotColor")
                        }
                    },
                    'nov': {
                        latitude: 51.28,
                        longitude: 11.58,
                        tooltip: {content: contents["ATP 500"].get("NOV").get("content")},
                        href: `/tournaments/${contents["ATP 500"].get("NOV").get("id")}`,
                        size: 10,
                        attrs: {
                            fill: contents["ATP 500"].get("NOV").get("plotColor")
                        }
                    },
                    'han': {
                        latitude: 53.38,
                        longitude: 10.00,
                        tooltip: {content: contents["ATP 500"].get("HAN").get("content")},
                        href: `/tournaments/${contents["ATP 500"].get("HAN").get("id")}`,
                        size: 10,
                        attrs: {
                            fill: contents["ATP 500"].get("HAN").get("plotColor")
                        }
                    },
                    'city': {
                        latitude: 38.9041,
                        longitude: -77.0171,
                        tooltip: {content: contents["ATP 500"].get("CITY").get("content")},
                        href: `/tournaments/${contents["ATP 500"].get("CITY").get("id")}`,
                        size: 10,
                        attrs: {
                            fill: contents["ATP 500"].get("CITY").get("plotColor")
                        }
                    },
                    'chi': {
                        latitude: 39.54,
                        longitude: 116.24,
                        tooltip: {content: contents["ATP 500"].get("CHI").get("content")},
                        href: `/tournaments/${contents["ATP 500"].get("CHI").get("id")}`,
                        size: 10,
                        attrs: {
                            fill: contents["ATP 500"].get("CHI").get("plotColor")
                        }
                    },
                    'tok': {
                        latitude: 35.39,
                        longitude: 139.32,
                        tooltip: {content: contents["ATP 500"].get("TOK").get("content")},
                        href: `/tournaments/${contents["ATP 500"].get("TOK").get("id")}`,
                        size: 10,
                        attrs: {
                            fill: contents["ATP 500"].get("TOK").get("plotColor")
                        }
                    },
                    'el': {
                        latitude: 48.13,
                        longitude: 16.22,
                        tooltip: {content: contents["ATP 500"].get("EL").get("content")},
                        href: `/tournaments/${contents["ATP 500"].get("EL").get("id")}`,
                        size: 10,
                        attrs: {
                            fill: contents["ATP 500"].get("EL").get("plotColor")
                        }
                    },
                    'in': {
                        latitude: 47.34,
                        longitude: 7.36,
                        tooltip: {content: contents["ATP 500"].get("IN").get("content")},
                        href: `/tournaments/${contents["ATP 500"].get("IN").get("id")}`,
                        size: 10,
                        attrs: {
                            fill: contents["ATP 500"].get("IN").get("plotColor")
                        }
                    },
                }
            });
            
    
        }).fail(function() {
            alert(error);
        })
    });



