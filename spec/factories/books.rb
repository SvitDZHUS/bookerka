# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    title { Faker::Book.title }
    author { Faker::Book.author }
    description { Faker::Lorem.paragraph }
    categories { [create(:category)] }
    publishing_house { Faker::Book.publisher }
    publishing_date { Faker::Date.between(from: '2014-09-23', to: '2021-09-25') }
    cover { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/test.jpg')) }
    language { Faker::ProgrammingLanguage.name }
  end

  trait :invalid_book do
    title { Faker::Lorem.characters(number: 2) }
  end
end
