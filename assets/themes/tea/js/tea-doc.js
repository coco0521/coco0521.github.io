/**
 * Created by UX on 5/6/14.
 */
(function($) {
    var $window = $(window);

    window.prettyPrint && prettyPrint();

    $('body').scrollspy({
        target: '.bs-docs-sidebar'
    });

    $('.bs-docs-sidenav').affix({
        offset: {
            top: 200
        }
    })

    $(".collapse").collapse({toggle:false});
    $('.carousel').carousel();

    $(".accordion-group").on('show', function(){
        console.info(arguments);
        var icon = $(this).find('.icon-chevron');
        icon.removeClass("icon-chevron-down");
        icon.addClass("icon-chevron-up");
        console.info(icon);
    });

    $(".accordion-group").on('hide', function(){
        console.info(arguments);
        var icon = $(this).find('.icon-chevron');
        icon.removeClass("icon-chevron-up");
        icon.addClass("icon-chevron-down");
        console.info(icon);
    });

})(jQuery);