$ ->
  $('#tree_about_prot_works').jstree({
    'core' : {
      'check_callback' : true,
      "themes" : { "theme" : "default-dark","icons" : false },
      'state' : { key : "demo2" }
    },
    "plugins" : [ "dnd" ]
  })


  $('#tree_about_prot_works2').jstree({
    'core' : {
      'check_callback' : true,
      "themes" : { "theme" : "default-dark","icons" : false },
      'state' : { key : "demo2" }
    },
    "plugins" : [ "dnd" ]
  })
