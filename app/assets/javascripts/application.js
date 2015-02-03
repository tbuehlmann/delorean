//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require jquery-ui
//= require twitter/bootstrap
//= require turbolinks
//= require jquery.timeago
//= require_tree .

Turbolinks.enableProgressBar();

$(document).on('ready page:load', function() {
  $('time.timeago').timeago();
});
