# frozen_string_literal: true

class CategoryPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    true
  end

  def new?
    true
  end

  def update?
    true
  end

  def edit?
    true
  end

  def destroy?
    true
  end
end
