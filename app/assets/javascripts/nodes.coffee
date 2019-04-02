# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
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
      $('#saving').html('保存終了 同期中...')
      $('#saving').css('color', '#00BB00')
      jstree.refresh()
      # もしjstree.selected_nodeがなかったらresをget_selectする
    })

  $('#edit_node').on 'click', ->
    $('#show_node').hide()
    $('#edit_form').show()
    $('#edit_node').hide()
    $('#view_node').show()
    $('#saving').html('')

  $('#view_node').on 'click', ->
    $('#edit_form').hide()
    $('#show_node').show()
    $('#view_node').hide()
    $('#edit_node').show()
    $('#saving').html('')

  # nodeがselectされたときにタイトルと本文を出力する。
  $('#jstree_nodes').on "select_node.jstree", (e, node) ->
    if $('#saving').html() == '保存終了 同期中...'
      console.log ("同期")
      $('#saving').html('同期しました！')
    else if $('#saving').html() == "待機中...(同期されるまで入力操作以外行わないでください)"
      console.log ("待機")
      return
    else
      console.log ("selected")
      body = node.node.data
      id   = node.node.id
      prot_id = REGISTRY.prot_id

      $("#show_node").text("#{body}")
      $("#nodeBodyFrom_#{id}").val("#{body}")
      $(".node-form-invisible").hide()
      $("#nodeBodyFrom_#{id}").show()
      $("#nodeBodyFrom_#{id}").on 'input', ->
        $('#saving').html("待機中...(同期されるまで入力操作以外行わないでください)")
        $('#saving').css('color', 'black')

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
        new_node_form = '<textarea id="nodeBodyFrom_'+ "#{res.id}" +'" class="form-control node-form-invisible" style="display: node;" rows="80" cols="80"></textarea>'
        $('#edit_form').append(new_node_form)
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
      })
    else
      return "/prots/#{REGISTRY.prot_id}/nodes.json"
