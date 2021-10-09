/*
$(window).on('load',function(){
    let pathName = $(location).attr('pathname');
    console.log(pathName);
    if (pathName != '/') {
        $('header').addClass('independent');
        $('.height-adjust').css('height', '80px');
    }
});
*/


$(function () {

    $(window).scroll(function () {
        let pathName = $(location).attr('pathname');
        let windowHeight = $(window).height();
        // console.log(windowHeight);
        let scroll = $(window).scrollTop();
        // console.log(scroll);
        if (pathName == '/') {
            if (scroll >= windowHeight) {
                // console.log("mizu");
                $('header').addClass('independent');
                if ($(window).width() < 768) {
                    $('#top-logo').css('display', 'none');
                    $('.fixed-menu').css('display', 'block');
                }
            } else {
                $('header').removeClass('independent');
                if ($(window).width() < 768) {
                    $('#top-logo').css('display', 'block');
                    $('.fixed-menu').css('display', 'none');
                }
            }
        }
    })
});


