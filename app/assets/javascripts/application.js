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
//= require announcements
//= require jquery.turbolinks
//= require bootstrap
//= require filterrific/filterrific-jquery
//= require turbolinks
//= require bootstrap-datepicker/core
//= require rails.validations
//= require commontator/application
//= require toastr
//= require js-routes
//= require select2-full
//= require nprogress
//= require nprogress-turbolinks
//= require_tree .


NProgress.configure({
  showSpinner: true,
  ease: 'ease',
  speed: 200
});

$(document).ready(function(){
  document.cookie = 'time_zone='+jstz.determine().name()+';';
});

$('button').click(function(){
  this.addClass('active-now');
});


$('a').click(function(){
  this.addClass('active-now');
});
