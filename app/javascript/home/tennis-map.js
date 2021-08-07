
$(function () {
    $(".container").mapael({
        map : {
            name : "world_countries"
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


