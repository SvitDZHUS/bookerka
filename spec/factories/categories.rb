# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    category_name { Faker::Lorem.characters(number: 20) }
  end
end
