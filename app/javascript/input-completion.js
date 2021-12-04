$(function() {
    $(document).on('focus', '.search-box', function(e) {
        if (!$(this).data("autocomplete")) {
            $(this).autocomplete({
                source: function(request, response) {
                    $.ajax({
                        type: "GET",
                        url: "/get_search_candidates",
                        dataType: "json",
                        data: {
                            name: request.term
                        },
                        success: function(data) {
                            let completeList = [];
                        
                            for(let tournament of data["tournaments"]) {
                                completeList.push(tournament["name"]);
                            }
                            for(let player of data["players"]) {
                                completeList.push(player["name"]);
                            }
                            for(let fullNamePlayer of data["full_name_players"]) {
                                completeList.push(fullNamePlayer["full_name"]);
                            }
                            // console.log(completeList);
                            response(completeList);
                        }
                    });
                }
            });
        }

    });

});
