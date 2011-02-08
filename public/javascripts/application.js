// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function() {
  $('#previous_orders').change(function() {
    description_and_price = eval($(this).val());
    $("#order_description").text(description_and_price[0]);
    $("#order_price"       ).val(description_and_price[1]);
    $("#inplace_edit_banner").text("Make sure to hit submit!")
  });
});
