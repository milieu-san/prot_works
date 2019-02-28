$(document).on('turbolinks:load', function() {
  var i = $('.media_form').length;
  $('#add_media_form').on('click', function() {
    var input =
        '<div class="media_form">'
        +'<label for="media_types_attributes_'+ i +'_name"></label>'
        +'<input type="text" name="prot[media_types_attributes]['+ i +'][name]" id="prot_media_types_attributes_'+ i +'_name">'
        +'</div>'
    $('#field_media_form').append(input);
    i ++ ;
  });
});
