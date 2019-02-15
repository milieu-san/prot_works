
json.array!(@nodes) do |node|
  json.id     node.id.to_s
  json.text   node.title
  json.data   node.body
  json.parent node.parent_id ? node.parent_id.to_s : '#'
end
