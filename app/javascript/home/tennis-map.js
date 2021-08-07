
$(function () {
    $(".container").mapael({
        map : {
            name : "world_countries",
            defaultArea: {
                attrsHover: {
                    fill: "#343434",
                    stroke: "#5d5d5d",
                }
            }
        },
        plots: {
        'ny': {
            latitude: 40.717079,
            longitude: -74.00116,
            tooltip: {content: "New York"},
            href: "/"
        }
        }
    });
});


