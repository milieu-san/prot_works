class Genre < ApplicationRecord
  validates :name, presence: true, length: { maximum: 16 }

  has_many :prot_genres, dependent: :destroy
  has_many :prots, through: :prot_genres
end
