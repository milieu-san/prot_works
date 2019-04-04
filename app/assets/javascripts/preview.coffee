$(document).on 'turbolinks:load', ->

  $('#jstree_nodes_preview').jstree({
    'core' : {
      'check_callback' : true,
      "themes" : { "theme" : "default-dark","icons" : false },
      'state' : { key : "demo2" },
      'data' : {
        'url' : (node) ->
          return "/preview/nodes.json?prot_id=#{REGISTRY.prot_id}"
      }
    },
    "plugins" : [ "state" ]
  })

  $('#jstree_nodes_preview').on "select_node.jstree", (e, node) ->
    title = node.node.text
    body = node.node.data
    id   = node.node.id
    prot_id = REGISTRY.prot_id

    $("#show_node_preview").text("#{body}")
    $(".nodeTitle").html("- #{title} -")


  fontSize = 1.0
  $('#fontSizeLargerPreview').on 'click', ->
    if fontSize < 2.0
      fontSize += 0.1
      $('.box11').css('font-size', "#{fontSize}rem")
    else
      return

  $('#fontSizeSmallerPreview').on 'click', ->
    if fontSize > 0.5
      fontSize -= 0.1
      $('.box11').css('font-size', "#{fontSize}rem")
    else
      return

  treeViewSize = 5
  textAreaSize = 7
  $('#boardResizeLeftPreview').on 'click', ->
    if treeViewSize > 3
      $('#treePreviewBoard').removeClass("col-#{treeViewSize}")
      treeViewSize -= 1
      $('#treePreviewBoard').addClass("col-#{treeViewSize}")
      $('#nodePreviewBoard').removeClass("col-#{textAreaSize}")
      textAreaSize += 1
      $('#nodePreviewBoard').addClass("col-#{textAreaSize}")
    else
      return

  $('#boardResizeRightPreview').on 'click', ->
    if textAreaSize > 3
      $('#treePreviewBoard').removeClass("col-#{treeViewSize}")
      treeViewSize += 1
      $('#treePreviewBoard').addClass("col-#{treeViewSize}")
      $('#nodePreviewBoard').removeClass("col-#{textAreaSize}")
      textAreaSize -= 1
      $('#nodePreviewBoard').addClass("col-#{textAreaSize}")
    else
      return

  nightView = false
  $('#nightVeiwSwitchPreview').on 'click', ->
    if nightView == false
      nightView = true
      $('body').css('background-color', '#3c3c3c')
      $('body').css('color', '#afafaf')
      $('.box11').css('background-color', '#3c3c3c')
      $('.box11').css('color', '#afafaf')
      $('.card').css('background-color', '#3c3c3c')
    else
      nightView = false
      $('body').animate({'background-color', 'white'}, 2000)
      $('body').css('color', '#212529')
      $('.box11').animate({'background-color', 'white'}, 2000)
      $('.box11').css('color', '#212529')
      $('.card').animate({'background-color', 'white'}, 2000)
