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
//= require jquery.turbolinks
//= require jquery_ujs
//= require jquery-ui/widget
//= require jquery.remotipart
//= require bootstrap
//= require chosen-jquery
//= require rails.validations
//= require commontator/application
//= require moment
//= require jstz
//= require toastr
//= require js-routes
//= require nprogress
//= require nprogress-turbolinks
//= require cable
//= require fullcalendar

//= require turbolinks

//= require announcements
//= require ckeditor/init
//= require chat_initialize
//= require appearance
//= require banners
//= require complaints
//= require init_ckeditor
//= require loader
//= require filterrific/filterrific-jquery
//= require messages
//= require products
//= require posts
//= require tasks
//= require mutiple_image_previewer

//= require pagination


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
