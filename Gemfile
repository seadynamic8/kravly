source 'https://rubygems.org'

ruby '2.0.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

# Use postgresql as the database for Active Record
gem 'pg'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0.rc2'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

gem 'jquery-turbolinks'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :production do
	gem 'rails_12factor'
	gem 'newrelic_rpm'
end

group :development do
	gem 'letter_opener'
end

group :development, :test do
	gem 'rspec-rails'
	gem 'factory_girl_rails'
	gem 'guard-rspec', require: false
	gem 'rb-inotify', require: false
	gem 'rb-readline', require: false
  gem 'watchr'
  gem 'annotate', ">=2.5.0"
end

group :test do
	gem 'faker'
	gem 'capybara'
	gem 'database_cleaner'
	gem 'launchy'
	gem 'shoulda-matchers'
	# gem 'selenium-webdriver'
	gem 'capybara-webkit'
end

# Use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

gem 'compass-rails', ">= 2.0.alpha.0"
gem 'zurb-foundation', '>= 4.0.9'

gem 'attribute_normalizer'

gem 'ckeditor'

gem 'carrierwave' # Photo uploads
gem 'mini_magick' # Imagemagick command line wrapper
gem 'fog' # Allow connect to Amazon S3 Cloud service
gem 'unf' # Supporter for fog

gem 'will_paginate'

gem 'figaro' # Stores Environment Variables Outside

gem 'pg_search'

gem 'acts_as_commentable_with_threading',
	git: "https://github.com/mikeatlas/acts_as_commentable_with_threading"
# gem 'acts_as_commentable_with_threading', 
# 		git: "git://github.com/epiclist/acts_as_commentable_with_threading.git", 
# 		ref: 'dafd24'

gem 'friendly_id'

gem 'impressionist'