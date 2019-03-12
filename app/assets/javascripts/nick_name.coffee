$(document).on 'turbolinks:load', ->
  _ = require 'lodash'

  name_check = ->
  nick = $('#nameId').val()
  console.log(nick)

  $.ajax({
    'type'    : 'GET',
    'data'    : { 'query' : nick },
    'url'     : "/users/name"
    'success' : (res) ->
      if res.result == 'findUser'
        $('#nickname_valid').html("その表示名は使われています")
        $('#nickname_valid').css('color', 'red')
      else if res.result == 'notFind'
        $('#nickname_valid').html("有効な表示名です")
        $('#nickname_valid').css('color', '#00BB00')
  })

  $('#nameId').on 'input', _.debounse( name_check(), 1500 )
