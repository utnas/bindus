//= require jquery
//= require socket.io
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require_tree .

$(document).ready(function () {
    window.setTimeout(function () {
        $('.alert').fadeTo(500, 0).slideUp(500, function () {
            $(this).remove();
        });
    }, 500);
});