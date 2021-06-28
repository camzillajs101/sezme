$(document).ready(() => {
  function fill(id){
    $(`#star-${id}`).addClass('filled');
  }
  function line(id){
    $(`#star-${id}`).removeClass('filled');
  }

  $('.ratinginput').html('');
  for (let i = 0; i < 5; i++){
    $('.ratinginput').append(`<div id="star-${i}" class="star"></div>`);
  }

  let hiddeninput = $('input[name="review[rating]"]').val() / 10;
  if (hiddeninput !== NaN){
    for (let i = 0; i < hiddeninput; i++){
      fill(i);
    }
  }

  let hold = hiddeninput !== NaN ? hiddeninput - 1 : -1; // represents which rating the user has selected; starts at -1 to signify no hold

  $('.star').hover(e => { // TODO: dry this up!
    let id = Number(e.target.id.substring(5,6));
    if (e.type === "mouseenter"){  // if mouseenter:
      for (let i = 0; i < 5; i++){ // run through stars and fill them up to event id
        if (i <= id){
          fill(i);
        } else {                   // make sure the rest after event id are empty
          line(i);
        }
      }
    } else {                       // if mouseleave:
      for (let i = 0; i < 5; i++){ // run through stars and [finish explanation]
        if (i <= hold){
          fill(i);
        } else {
          line(i);
        }
      }
    }
  });

  $('.star').click(e => {
    hold = Number(e.target.id.substring(5,6));
    $('input[name="review[rating]"]').val((hold+1)*10); // TODO: at some point (not super important) add ability to select half stars. Maybe html maps?
  });

  $('.new-review-form textarea').on('input', () => {
    let length = $('.new-review-form textarea').val().length;
    $('.new-review-form .charcount').text(length+"/2000");
    if (length > 2000){
      $('.new-review-form .charcount').css('color','red');
    } else {
      $('.new-review-form .charcount').css('color','');
    }
  });
});
