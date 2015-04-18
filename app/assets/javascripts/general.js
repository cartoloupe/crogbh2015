$( function() {
  $("body").hammer().on("swiperight", function (e) {
    $('.left.carousel-control').click();
    console.log("swiped right");
  }).on("swipeleft", function (e) {
    $('.right.carousel-control').click();
    console.log("swiped left");
  });
});

