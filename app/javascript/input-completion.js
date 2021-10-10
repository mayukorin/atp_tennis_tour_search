/*
$(function () {
    $('.search-box2').autocomplete({
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
    */

/*
$(function() {
    $(document).on('input', '.search-box2', function(e) {
        console.log("これはできる");
    });
});
*/
$(function() {
    /*
    $(document).on('keydown', '.search-box2', function(e) {
        console.log("これは");
    });
    */
    $(document).on('focus', '.search-box2', function(e) {
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
                            console.log(completeList);
                            response(completeList);
                        }
                    });
                }
            });
        }

    });
    /*
    $(document).on('autocomplete', '.search-box2', {
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
    */

    /*
    $('.search-box2').autocomplete({
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
    */

});
/*
$('.search-box2').autocomplete({
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
    
});
*/