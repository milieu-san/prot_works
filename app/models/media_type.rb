# frozen_string_literal: true

class MediaType < ApplicationRecord
  has_many :prot_media_types, dependent: :destroy
  has_many :prots, through: :prot_media_types

  validates :name, presence: true, length: { maximum: 16 }
end
