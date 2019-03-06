$(document).on 'turbolinks:load', ->
  $('#nameId').on 'input', ->
    nick = $('#nameId').val()

    $.ajax({
      'type'    : 'GET',
      'data'    : { 'query' : nick },
      'url'     : "/users/name"
      'success' : (res) ->
        if res.result == 'findUser'
          $('#nickname_valid').html("その表示名は使われています")
          $('#nickname_valid').css('color', 'red')
        else
          $('#nickname_valid').html("有効な表示名です")
          $('#nickname_valid').css('color', '#00BB00')
    })
