# frozen_string_literal: true

class Profile < ApplicationRecord
  include OwnedBy

  validates :first_name, presence: true, length: { minimum: 3, maximum: 255 }, on: :update
  validates :last_name, presence: true, length: { minimum: 3, maximum: 255 }, on: :update
end
