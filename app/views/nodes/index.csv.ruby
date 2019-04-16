# frozen_string_literal: true

require 'csv'

CSV.generate do |csv|
  csv_column_names = %w[ID タイトル 本文 親 序列]
  csv << csv_column_names
  @nodes.each do |node|
    csv_column_values = [
      node.id,
      node.title,
      node.body,
      node.parent_id,
      node.position + 1
    ]
    csv << csv_column_values
  end
end
