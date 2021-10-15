$(function() {
    $(document).on('focus', '.search-box', function(e) {
        if (!$(this).data("autocomplete")) {
            $(this).autocomplete({
                source: function(request, response) {
                    $.ajax({
                        type: "GET",
                        url: "/get_tournament_list",
                        dataType: "json",
                        data: {
                            name: request.term
                        },
                        success: function(data) {
                            let completeList = [];
                        
                            for(let tournament of data["tournaments"]) {
                                completeList.push(tournament["name"]);
                            }
                            for(let tournament of data["players"]) {
                                completeList.push(tournament["name"]);
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
