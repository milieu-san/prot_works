# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
  nightView = false

  $('#jstree_nodes').jstree({
    'core' : {
      'check_callback' : true,
      "themes" : { "theme" : "default","icons" : false },
      'state' : { key : "demo2" },
      'data' : {
        'url' : (node) ->
          return "/prots/#{REGISTRY.prot_id}/nodes.json"
      }
    },
    "plugins" : [ "dnd", "state" ]
  })

  # bodyのオートセーブ
  autoSave = (id)->
    jstree = $('#jstree_nodes').jstree(true)
    selectorId = id.target.id
    nodeId = selectorId.replace("nodeBodyFrom_", "")
    nodeBody = $("#nodeBodyFrom_#{nodeId}").val()

    $.ajax({
      'type'    : 'PATCH',
      'data'    : { 'node' : { 'body' : nodeBody } },
      'url'     : "/prots/#{REGISTRY.prot_id}/nodes/#{nodeId}.json"
    'success' : (res) ->
      $('#saving').html('保存完了')
      $('#saving').css('color', '#64aa64')
    })

  # nodeがselectされたときにタイトルと本文を出力する。
  $('#jstree_nodes').on "select_node.jstree", (e, node) ->
    title = node.node.text
    id   = node.node.id
    prot_id = REGISTRY.prot_id

    $(".node-form-invisible").hide()
    $("#nodeBodyFrom_#{id}").show()
    $("#nodeTitle").html("「#{title}」")
    $("#nodeBodyFrom_#{id}").on 'input', ->
      $('#saving').html("待機中...")
      $('#saving').css('color', 'gray')

    $("#nodeBodyFrom_#{id}").on('input', _.debounce( autoSave, 1000 ))

  # ノードを移動させたときに呼ばれるイベント
  $('#jstree_nodes').on "move_node.jstree", (e, node) ->
    id            = node.node.id
    parent_id     = node.parent
    new_position  = node.position

    # PATCH /nodes/id.json
    $.ajax({
      'type'    : 'PATCH',
      'data'    : { 'node' : { 'parent_id' : parent_id, 'new_position' : new_position } },
      'url'     : "/prots/#{REGISTRY.prot_id}/nodes/#{id}.json"
    })

  # 選択されているノードの子として新しいノードを作成する
  $('#make_node').on 'click', ->
    jstree = $('#jstree_nodes').jstree(true)
    selected = jstree.get_selected()
    return false if (!selected.length)
    selected = selected[0]
    prot_id = REGISTRY.prot_id

    # POST /nodes.json
    $.ajax({
      'type'    : 'POST',
      'data'    : { 'node' : { 'title' : 'New node', 'parent_id' : selected , 'prot_id' : prot_id , 'new_position' : 0 , 'body' : "本文" } },
      'url'     : "/prots/#{REGISTRY.prot_id}/nodes.json",
      'success' : (res) ->
        res.data = "本文"
        new_node_form = '<textarea id="nodeBodyFrom_'+ "#{res.id}" +'" class="form-control node-form-invisible" style="display: node;" rows="80" cols="80">本文</textarea>'
        $('#edit_form').append(new_node_form)
        if nightView
          $("#nodeBodyFrom_#{res.id}").css('background-color', '#3c3c3c')
          $("#nodeBodyFrom_#{res.id}").css('color', '#afafaf')
        selected = jstree.create_node(selected, res)
        jstree.edit(selected) if (selected)
    })

  # 選択されているノードの名前を変更する
  $('#rename_node').on 'click', ->
    jstree = $('#jstree_nodes').jstree(true)
    selected = jstree.get_selected()
    return false if (!selected.length)

    selected = selected[0]
    jstree.edit(selected);

  # ノードの名前の変更が確定されたときに呼ばれるイベント
  $('#jstree_nodes').on 'rename_node.jstree', (e, obj) ->
    id           = obj.node.id
    renamed_name = obj.text

    # PATCH /nodes/id.json
    $.ajax({
      'type'    : 'PATCH',
      'data'    : { 'node' : { 'title' : renamed_name } },
      'url'     : "/prots/#{REGISTRY.prot_id}/nodes/#{id}.json"
      'success' : (res) ->
        jstree = $('#jstree_nodes').jstree(true)
        selected = jstree.get_selected()
        if id == selected[0]
          $("#nodeTitle").html("「#{renamed_name}」")
    })

  # 選択されているノードを削除する
  $('#delete_node').on 'click', ->
    jstree = $('#jstree_nodes').jstree(true)
    selected = jstree.get_selected()
    return false if (!selected.length)

    selected = selected[0]
    id = selected

    conf = (confirm('*注意！*\nノードを削除すると、子供のノードも全て消えてしまいます！\nそれでもよろしいですか？'))
    # DELETE /nodes/id.json
    if conf == true
      $.ajax({
        'type'    : 'DELETE',
        'url'     : "/prots/#{REGISTRY.prot_id}/nodes/#{id}.json",
        'success' : ->
          jstree.delete_node(selected)
          $("#nodeBodyFrom_#{id}").remove()
      })
    else
      return "/prots/#{REGISTRY.prot_id}/nodes.json"

  $("#edit_form").resizable({});

  fontSize = 1.0
  $('#fontSizeLarger').on 'click', ->
    if fontSize < 2.0
      fontSize += 0.1
      $('.form-control').css('font-size', "#{fontSize}rem")
    else
      return

  $('#fontSizeSmaller').on 'click', ->
    if fontSize > 0.5
      fontSize -= 0.1
      $('.form-control').css('font-size', "#{fontSize}rem")
    else
      return

  treeViewSize = 5
  textAreaSize = 7
  $('#boardResizeLeft').on 'click', ->
    if treeViewSize > 3
      $('#treeViewBoard').removeClass("col-#{treeViewSize}")
      treeViewSize -= 1
      $('#treeViewBoard').addClass("col-#{treeViewSize}")
      $('#nodeEditBoard').removeClass("col-#{textAreaSize}")
      textAreaSize += 1
      $('#nodeEditBoard').addClass("col-#{textAreaSize}")
    else
      return

  $('#boardResizeRight').on 'click', ->
    if textAreaSize > 3
      $('#treeViewBoard').removeClass("col-#{treeViewSize}")
      treeViewSize += 1
      $('#treeViewBoard').addClass("col-#{treeViewSize}")
      $('#nodeEditBoard').removeClass("col-#{textAreaSize}")
      textAreaSize -= 1
      $('#nodeEditBoard').addClass("col-#{textAreaSize}")
    else
      return

  $('#nightVeiwSwitch').on 'click', ->
    if nightView == false
      $('body').css('background-color', '#3c3c3c')
      $('body').css('color', '#afafaf')
      $('.form-control').css('background-color', '#3c3c3c')
      $('.form-control').css('color', '#afafaf')
      $('.card').css('background-color', '#3c3c3c')
      nightView = true
    else
      $('body').animate({'background-color', 'white'}, 2000)
      $('body').css('color', '#212529')
      $('.form-control').animate({'background-color', 'white'}, 2000)
      $('.form-control').css('color', '#212529')
      $('.card').animate({'background-color', 'white'}, 2000)
      nightView = false
