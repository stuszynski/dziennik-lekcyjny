
$(document).ready(function() {

  $('.index progress').map(function () {

    var progress = $(this).attr('value');

    // console.log($(this).attr('value'));

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
  });

  $('a[data-type=\"json\"]').bind('ajax:success', function(event, data, status, xhr) {
    var div = $(this).parent();  // link == this

    // console.log(div);

    div.html('☻'); // replace content div.presence with the black smiley

    var absences = div.parent().find('.absences');

    // console.log(absences);
    // console.log(JSON.stringify(data));

    absences.html(data.value);
  });

});
