
$(document).ready(function() {

  $('.index progress').map(function () {

    var progress = $(this).attr('value');

    switch(true) {
    case (progress <= .4):
      $(this).addClass('ndst');
      break;
    case (progress <= .6):
      $(this).addClass('dst');
      break;
    case (progress <= .8):
      $(this).addClass('db');
      break;
    case (progress <= 1):
      $(this).addClass('bdb');
      break;
    }
    //console.log($(this).attr('value'));

    });

});
