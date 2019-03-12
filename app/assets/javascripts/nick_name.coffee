$(document).on 'turbolinks:load', ->
  name_check = ->
    nick = $('#nameId').val()

    $.ajax({
      'type'    : 'GET',
      'data'    : { 'query' : nick },
      'url'     : "/users/name"
      'success' : (res) ->
        if res.result == 'findUser'
          $('#nickname_valid').html("その表示名は使われています")
          $('#nickname_valid').css('color', 'red')
        else if res.result == 'notFind'
          $('#nickname_valid').html("その表示名は使われていません")
          $('#nickname_valid').css('color', '#00BB00')
    })

  $('#nameId').on 'input', ->
    $('#nickname_valid').html("検索中...")
    $('#nickname_valid').css('color', 'black')

  $('#nameId').on('input', _.debounce( name_check, 1000 ))
