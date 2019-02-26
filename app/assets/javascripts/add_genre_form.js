$(function() {
  var i = $('.genre_form').length;
  $('#add_genre_form').on('click', function() {
    var input =
        '<div class="genre_form">'
        +'<label for="genres_attributes_'+ i +'_name"></label>'
        +'<input type="text" name="prot[genres_attributes]['+ i +'][name]" id="genres_attributes_'+ i +'_name">'
        +'</div>'
    $('#field_genre_form').append(input);
    i ++ ;
  });
});
