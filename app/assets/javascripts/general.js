$( function() {
  $("body").hammer().on("swipe", function (e) {
    //console.log('gesture');
    $('#next_page').click();
  });
});

