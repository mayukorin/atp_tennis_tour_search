
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
            href: "/",
            size: 10,
        }, 
        'me': {
            latitude: -37.814,
            longitude: 144.96332,
            tooltip: {content: "Melbourne"},
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
});


