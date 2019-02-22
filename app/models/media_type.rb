class MediaType < ApplicationRecord
  validates :name, presence: true, length: { maximum: 16 }

  has_many :prot_media_types, dependent: :destroy
  has_many :prots, through: :prot_media_types
end
