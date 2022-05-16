# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_one :profile, inverse_of: :owned_by, foreign_key: 'owned_by_id', dependent: :destroy

  after_create :init_profile

  def init_profile
    self.create_profile!
  end
end
