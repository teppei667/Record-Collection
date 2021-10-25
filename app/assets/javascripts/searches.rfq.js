/*global $*/
  $(document).on('turbolinks:load', function() {
    $(document).on('input', '.search_word', function(){
  
      $('.search-record').html('');
  
      var keyword = $(this).val();
  
      $.ajax({
        type: 'GET',
        url: '/records',
        data: {keyword: keyword},
        dataType: 'script'
      });
  
    });
  });
  
  $(document).on('turbolinks:load', function() {
    $(document).on('input', '.search_word', function(){
  
      $('.search-enduser').html('');
  
      var keyword = $(this).val();
  
      $.ajax({
        type: 'GET',
        url: '/end_users',
        data: {keyword: keyword},
        dataType: 'script'
      });
  
    });
  });