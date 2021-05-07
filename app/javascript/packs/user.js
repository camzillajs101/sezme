$(document).ready(() => {
  function showPosts(){
    $('.user-reviews').hide();
    $('.user-posts').show();
  }
  function showReviews(){
    $('.user-posts').hide();
    $('.user-reviews').show();
  }

  // by default show posts
  showPosts();

  // click listeners
  $('#poststab').click(() => {
    showPosts();
  });
  $('#reviewstab').click(() => {
    showReviews();
  })
});
