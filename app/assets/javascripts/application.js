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
//= require_tree .

$(document).ready(function(){
  var docName, docId, userId;
  docId  = 1
  userId = 1
  $('.doctors').on("click", ".doctor", function(){
  //  docId = $(this).find('.docid').html();
   docName = $(this).find('.docname').html();
  //  userId = $('.user_id').html();
  //  console.log(parseInt(userId));
  //  console.log(docName);
  //  console.log(parseInt(docId));
  //  console.log(moment('2016-06-01T00:00:00Z').format('ddd MMM DD YYYY HH:mm'));
  });

  $('.doctors').find('.docid, .user_id').hide();
  $('#calendar').html("")



  $('#user-booking-calendar').fullCalendar({
      header: {
          left: 'today',
          center: 'prev title next',
          right: 'month,agendaWeek',
      },
      minTime: "07:00:00",
      maxTime: "21:00:00",
      allDaySlot: false,
      defaultView :'agendaWeek',
      height: 600,
      events:'/doctors/1/availabilities.json',
      eventClick: function(event) {
        console.log(event.start._i);
        var startTime  = event.start._i
        var endTime    = event.end._i
        console.log(event);
        swal({ title: "Booking Confirmation",
          text: "Booking an appointment with Dr." +docName+" on " + moment(startTime).format('ddd MMM DD YYYY HH:mm'),
          // type: "info",
          imageUrl: 'http://www.mariowiki.com/images/7/76/DrMarioOnlineRxMarioIcon.png',
          showCancelButton: true,
          closeOnConfirm: false,
          showLoaderOnConfirm: true,
        },
        function(){
          $.ajax({
            method: "POST",
            url: "/users/"+ userId + "/appointments",
            data: {appointment: { user_id: userId, doctor_id: docId, start: startTime, end: endTime}},
            error: function(){
              setTimeout(function(){
               console.log("error");
               swal({
                 title: "Error!",
                 imageUrl: 'http://www.mariowiki.com/images/0/01/Goomba_Cut-in_PD-SMBE.png',
               text: "A error has occured, please try again later!"}); }, 1000);
            },
            success: function(data){
              setTimeout(function(){
               console.log("confirmed");
               swal("Confirmed!", '', 'success');}, 1000);
            }
          })
        })
    },
});
$('.fc-widget-header').addClass('user');
})
