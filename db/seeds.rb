# frozen_string_literal: true

require 'factory_bot_rails'

# Create user.

FactoryBot.create(:user)
Rails.logger.info 'Created user'

# Create categories.

10.times do
  FactoryBot.create(:category)
end
Rails.logger.info 'Created 10 categories of books'

# Create books.

10.times do
  FactoryBot.create(:book)
end
Rails.logger.info 'Created 10 books'
