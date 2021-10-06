$(function () {
    $('#search-box').autocomplete({
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
                    console.log(completeList);
                    response(completeList);
                }
            });
        }
    });


    /*
    $.ajax({
        type: "GET",
        url: "/get_tournament_list",
        dataType: "json"
    }).done(function(response){
        console.log(response);
        console.log(response["tournaments"]);
        let completeList = [];
        for(let tournament of response["tournaments"]) {
            completeList.push(tournament["name"]);
        }
        for(let tournament of response["players"]) {
            completeList.push(tournament["name"]);
        }

        $('#sbox2').autocomplete({
            source: completeList
        });
    });
    */
});