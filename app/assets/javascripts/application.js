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
//= require jquery.remotipart
//= require bootstrap
//= require announcements
//= require jquery.turbolinks
//= require chosen-jquery
//= require turbolinks
//= require loader
//= require rails.validations
//= require commontator/application
//= require toastr
//= require js-routes
//= require nprogress
//= require nprogress-turbolinks
//= require ckeditor/init
//= require chat_initialize
//= require moment 
//= require fullcalendar
//= require loader
//= require cable
//= require appearance
//= require banners
//= require complaints
//= require init_ckeditor
//= require jstz
//= require loader
//= require filterrific/filterrific-jquery
//= require messages
//= require products
//= require rails.validations
//= require posts
//= require tasks


NProgress.configure({
  showSpinner: true,
  ease: 'ease',
  speed: 200
});

document.addEventListener("turbolinks:load", function() {
  loadtimeEvents();
})

document.addEventListener("turbolinks:before-cache", function() {
  $("#calendar").datepicker('remove');
});

function loadtimeEvents(){
  // initChatObj();
  // checkAvailable();
  $("#calendar").datepicker('enable');
  document.cookie = 'time_zone='+jstz.determine().name()+';';
  $('button').click(function(){
    $(this).addClass('active-now');
  });

  $('a').click(function(){
    $(this).addClass('active-now');
  });
}
