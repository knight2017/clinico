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

  $('.doctors').on("click", ".doctor", function(){
   var session = $(this).find('span').html();
   console.log(session);
  });

  $('.doctors .doctor').find('span').hide();

  $('#calendar').html("")
    $('#calendar').fullCalendar({
        header: {
            left: 'today',
            center: 'prev title next',
            right: 'month,agendaWeek'
        },
        defaultView :'agendaWeek',
        height: 600,
        events: [
                {
                    title: 'Click Google',
                    start: '2016-08-01T10:00:00',
                    end: '2016-08-01T11:30:00',
                    // url: 'http://google.com/',
                    startEditable: true
                }
              // other events here
        ],
        eventClick: function(event) {
            console.log(event.start._i);
            var startTime  = event.start._i
            console.log(event);
            // if (event.url) {
            //     window.open(event.url);
            //     return false;
            // }
        }
});
})
