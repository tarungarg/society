document.addEventListener("turbolinks:load", function() {
  if ($('#infinite-scrolling').size() > 0) {
    $(window).on('scroll', function() {
      var more_posts_url;
      more_posts_url = $('.pagination a[rel=next]').attr('href');
      if (more_posts_url && $(window).scrollTop() > $(document).height() - $(window).height() - 200) {
        $('.pagination').html('Fetching more posts...');
        $.getScript(more_posts_url)
      }
      if (!more_posts_url) {
        return $('.pagination').html("");
      }
    });
  }

});
