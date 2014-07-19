
var set_message_timeout = function (selector) {
    window.setTimeout(function (selector) {
        $(selector).fadeTo(1500, 0).slideUp(500, function () {
            $(this).remove();
        });
    }, 700);
};