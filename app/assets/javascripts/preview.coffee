$ ->
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
    body = node.node.data
    id   = node.node.id
    prot_id = REGISTRY.prot_id

    $("#show_node_preview").text("#{body}")
