# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :user
  belongs_to :prot
  has_many :comments, dependent: :destroy

  has_many :goods, dependent: :destroy

  validates :title, presence: true, length: { maximum: 255 }
  validates :content, presence: true, length: { maximum: 65_535 }
end
