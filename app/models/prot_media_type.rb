# frozen_string_literal: true

class ProtMediaType < ApplicationRecord
  belongs_to :prot
  belongs_to :media_type

  validates :prot_id, presence: true, uniqueness: { scope: :media_type_id }
end
