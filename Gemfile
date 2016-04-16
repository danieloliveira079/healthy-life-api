source 'https://rubygems.org'

gem 'dotenv-rails', :groups => [:development, :test]
gem 'rails', '4.2.4'
gem 'rails-api'
gem 'pg'
gem 'active_model_serializers', github: 'rails-api/active_model_serializers'
gem 'bcrypt', '~> 3.1.7'
gem 'has_secure_token'
gem 'warden'

group :development do
  gem 'spring'
  gem 'spring-commands-rspec'
end

group :test do
  gem 'shoulda-matchers', require: false
  gem 'codeclimate-test-reporter', require: nil
end

group :development, :test do
  gem 'pry'
  gem 'rspec-rails', '~> 3.0'
end
