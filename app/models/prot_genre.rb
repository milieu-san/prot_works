# frozen_string_literal: true

class ProtGenre < ApplicationRecord
  belongs_to :prot
  belongs_to :genre

  validates :prot_id, presence: true, uniqueness: { scope: :genre_id }
end
