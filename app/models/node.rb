# frozen_string_literal: true

class Node < ApplicationRecord
  belongs_to :prot
  has_many :nodes, class_name: 'Node', foreign_key: 'parent_id', dependent: :destroy

  def parent_id=(parent_id)
    if parent_id == '#'
      update(parent_id: nil)
    else
      super(parent_id)
    end
  end

  # positionの管理
  def new_position=(new_position)
    roots = Prot.find(prot_id).nodes
                .where(parent_id: parent_id)
                .order(position: :asc)

    if roots.length >= 1 # 一つでも同じ階層にノードがある場合

      if id.nil? # create の場合
        update(parent_id: parent_id, position: roots.length)

      else # update の場合
        root_v = roots.where.not(id: id)
        insert_node = Node.find(id)
        root_a = root_v.to_a
        root_a.insert(new_position.to_i, insert_node)
        i = 0
        root_a.each do |root|
          root.update(position: i)
          i += 1
        end
      end

    else # 階層にノードがゼロの場合
      # 単純更新 create & update
      update(parent_id: parent_id, position: new_position.to_i)
    end
  end
end
