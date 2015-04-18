$( function() {
  $("body").hammer().on("swiperight", function (e) {
    $('.left.carousel-control').click();
  }).on("swipeleft", function (e) {
    $('.right.carousel-control').click();
  });
});

