// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require moment
//= require fullcalendar
//= require sweet-alert
//= require sweet-alert-confirm
//= require underscore
//= require gmaps/google
//= require_tree .

$(document).ready(function(){
  var docName, docId, userId;
  // docId  = 1
  // userId = 1
  // $('.doctors').on("click", ".doctor", function(){
  // //  docId = $(this).find('.docid').html();
  //  docName = $(this).find('.docname').html();
  // //  userId = $('.user_id').html();
  // //  console.log(parseInt(userId));
  // //  console.log(docName);
  // //  console.log(parseInt(docId));
  // //  console.log(moment('2016-06-01T00:00:00Z').format('ddd MMM DD YYYY HH:mm'));
  // });

  $('.doctors').find('.docid, .user_id').hide();
  $('#calendar').html("")

//
$('.fc-widget-header').addClass('user');
})
