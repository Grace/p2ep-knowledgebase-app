source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.0.1'
#gem 'activesupport', '~> 5.0.0.1'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails', '~> 4.2.1'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'

# neo4j version 7
gem 'neo4j', '~> 7'
# neo4j-core version 6
gem 'neo4j-core', '~> 6'
# devise-neo4j
gem 'devise-neo4j', '~> 2.0.2'
gem 'searchkick', '~> 1.4.1'
gem 'sidekiq', '~> 4.2.7'

gem 'materialize-sass', '~> 0.97.8'
gem 'json', '~> 2.0.2'
gem 'gon', '~> 6.1.0'
gem 'select2-rails', '~> 4.0.3'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development


group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', '~> 9.0.6', platform: :mri
  gem 'file-tail', '~> 1.1.1'
  gem 'figaro', '~> 1.1.1' # Provides Heroku-like control of app environment variables
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '~> 3.4.0'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring', '~> 2.0.0'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo sources, so bundle the tzinfo-data gem
gem 'tzinfo-data', '~> 1.2016.10', platforms: [:mingw, :mswin, :x64_mingw, :jruby]