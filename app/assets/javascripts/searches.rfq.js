$(document).on('turbolinks:load', function() {
  $(document).on('input', '.search_word', function(){

    $('.search-index').html('');

    var keyword = $(this).val();

    $.ajax({
      type: 'GET',
      url: '/records',
      data: {keyword: keyword},
      dataType: 'script'
    });

  });
});