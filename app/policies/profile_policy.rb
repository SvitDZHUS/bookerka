# frozen_string_literal: true

class ProfilePolicy < ApplicationPolicy
  def update?
    user_is_owner_of_record?
  end

  def edit?
    user_is_owner_of_record?
  end

  def show?
    user_is_owner_of_record?
  end
end
