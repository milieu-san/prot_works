# frozen_string_literal: true

class Heart < ApplicationRecord
  belongs_to :user
  belongs_to :prot

  validates :user_id, presence: true, uniqueness: { scope: :prot_id }
end
