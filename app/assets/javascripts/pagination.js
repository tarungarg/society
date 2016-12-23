document.addEventListener("turbolinks:load", function() {
  if ((location.pathname.indexOf('user_profile') > 0) && $('#infinite-scrolling') && $('#infinite-scrolling').size() > 0) {
    paginateContent('#infinite-scrolling');
  }

  if ((location.pathname.indexOf('timeline') > 0) && $('#timelines-paginate') && $('#timelines-paginate').size() > 0) {
    paginateContent('#timelines-paginate');
  }

});

function paginateContent(id){
  $(window).on('scroll', function() {
    var more_posts_url;
    more_posts_url = $(id +' '+'.pagination a[rel=next]').attr('href');
    if (more_posts_url && $(window).scrollTop() > $(document).height() - $(window).height() - 200) {
      $('.pagination').html('Loading...');
      $.getScript(more_posts_url)
    }
    if (!more_posts_url) {
      return $('.pagination').html("");
    }
  });
}

document.addEventListener("turbolinks:before-cache", function() {
  $(window).off('scroll')
});