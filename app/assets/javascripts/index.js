$(document).on('turbolinks:load', function() {
  $(function() {
      var openBar = $('#top-navbar2');
      openBar.hide();
      //スクロールが100に達したらボタン表示
      $(window).scroll(function () {
          if ($(this).scrollTop() > 100) {
              openBar.fadeIn();
          } else {
              openBar.fadeOut();
          }
      });
  });
});
