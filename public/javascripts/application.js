// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function() {
  $('#previous_orders').change(function() {
    description_and_price = eval($(this).val());
    $("#order_description").text(description_and_price[1]);
    $("#order_price"       ).val(description_and_price[2]);
    $("#inplace_edit_banner").text("Make sure to hit submit!")
  });

  $('#show_rating_details').click(function() {
    $('.rating_details').show();
  });
            
  // Always send the authenticity_token with ajax
  $(document).ajaxSend(function(event, request, settings) {
    if ( settings.type == 'post' ) {
      settings.data = (settings.data ? settings.data + "&" : "")
        + "authenticity_token=" + encodeURIComponent( csrf_token );
    }
  });
  
  $('.ajaxful-rating a').click(function(){
    $.ajax({
      type: $(this).attr('data-method'),
      url: $(this).attr('href'),
      data: {
        stars: $(this).attr('data-stars'),
        dimension: $(this).attr('data-dimension'),
        size: $(this).attr('data-size'),
        show_user_rating: $(this).attr('data-show_user_rating')
      },
      success: function(response){
        $('#' + response.id + ' .show-value').css('width', response.width + '%');
      }
    });
    return false;
  });

});
