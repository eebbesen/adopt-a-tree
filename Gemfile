source 'https://rubygems.org'
ruby '2.2.0'

gem 'rails', '~> 4.1.7'

gem 'autoprefixer-rails'
gem 'bcrypt'
gem 'bootstrap-sass'
gem 'devise'
gem 'geokit'
gem 'haml'
gem 'jquery-rails'
gem 'pg'
gem 'puma'
gem 'rails_admin'
gem 'sass-rails'
gem 'validates_formatting_of'

group :development do
  gem 'annotate'
  gem 'guard-rspec'
  gem 'libnotify' if /linux/ =~ RUBY_PLATFORM
  gem 'growl' if /darwin/ =~ RUBY_PLATFORM
  gem 'spring'
  gem 'spring-commands-rspec'
end

group :development, :test do
  gem 'dotenv-rails'
  gem 'factory_girl_rails'
  gem 'pry-rails'
  gem 'rspec-rails'
end

group :production do
  gem 'rails_12factor'
end

group :test do
  gem 'capybara'
  gem 'codeclimate-test-reporter', require: nil
  gem 'database_cleaner'
  gem 'faker'
  gem 'launchy'
  gem 'poltergeist'
  gem 'selenium-webdriver'
end
