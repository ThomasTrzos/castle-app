source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.1'
gem 'rails', '~> 6.0.3', '>= 6.0.3.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

gem 'pry', '~> 0.13.1'
gem 'redis', '~> 4.2', '>= 4.2.1'
gem 'redis-rails', '~> 5.0', '>= 5.0.2'
gem 'dry-validation', '~> 1.5', '>= 1.5.4'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails', '~> 6.1'
  gem 'rspec-rails', '~> 4.0', '>= 4.0.1'
  gem 'rubocop', '~> 0.89.1', require: false
  gem 'vcr', '~> 6.0'
  gem 'webmock', '~> 3.8', '>= 3.8.3'
end

group :test do
  gem 'airborne', '~> 0.3.5'
  gem 'database_cleaner', '~> 1.8', '>= 1.8.5'
  gem 'faker', '~> 2.13'
  gem 'guard-rspec', '~> 4.7', '>= 4.7.3'
  gem 'mock_redis', '~> 0.25.0'
  gem 'shoulda-matchers', '~> 4.3'
end

group :development do
  gem 'listen', '~> 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
