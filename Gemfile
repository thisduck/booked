LANG="en_US.UTF-8"
LC_ALL="en_US.UTF-8"

if RUBY_VERSION =~ /1.9/
  Encoding.default_external = Encoding::UTF_8
  Encoding.default_internal = Encoding::UTF_8
end

source 'https://rubygems.org'

gem 'rails', '3.2.2'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# database
gem 'bson_ext'
gem 'mongo_mapper'

# forms
gem 'simple_form'

# helpers
gem 'formatize'
gem 'mm-sluggable'
gem 'font-awesome-rails'
gem 'tipsy-rails'

# auth
gem 'omniauth'
gem 'omniauth-twitter'
gem 'omniauth-openid'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer'

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
gem 'thin'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :test do
  gem 'rspec-rails'
  gem 'cucumber-rails', :require => false
  gem 'capybara'
  gem 'database_cleaner'
  gem 'factory_girl_rails'
end

group :development do
  gem 'guard-spork'
  gem 'guard-cucumber'
  gem 'guard-rspec'
end

group :development, :test do
  gem 'awesome_print'
end

group :production do 
  gem 'therubyracer'
end
