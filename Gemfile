source 'https://rubygems.org'

# ruby '1.9.3'

gem 'rails', '~> 3.2.0'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'mongoid', '~> 3.1.0'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', '~> 3.2.0'

  gem 'uglifier', '~> 1.3.0'
end

gem 'dispatcher-rails',    '~> 0.0.1'
gem 'jquery-rails',        '~> 2.1.0'
gem 'kaminari',            github: 'amatsuda/kaminari' #'~> 0.13.0'

gem 'devise',              '~> 2.1.0'
gem 'mongoid_slug',        '~> 2.0.1'
gem 'localized_fields',    '~> 0.2.0'
gem 'mongoid-textile',     '~> 0.2.0'
gem 'publish',             '~> 0.2.0'
gem 'mail_form',           '~> 1.4.1'
gem 'state_machine',       '~> 1.1.2'
gem 'mongoid-simple-tags', '~> 0.1.1'
gem 'instagram',           '~> 0.9.1'

# Deploy with Capistrano
gem 'capistrano',     '~> 2.14.0'
gem 'rvm-capistrano', '~> 1.2.0'

# I18n
gem 'devise-i18n', '~> 0.5.0'
gem 'rails-i18n',  '~> 0.7.0'

# MediaMagick
gem 'media_magick', github: 'nudesign/media_magick', branch: 'v0.3'
gem 'mini_magick',  '~> 3.4'
gem 'piet',         '~> 0.1.0'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'

group :development, :production do
  gem 'mongodb_clone', '~> 0.0.1'
end

group :development do
  gem 'thin'

  gem 'mongoid_colored_logger', '~> 0.2.2'

  gem 'nu-generators',  '~> 0.0.2'
  gem 'draper',         '~> 1.0'

  # LiveReload
  gem 'guard-livereload', '~> 1.1.0'
  gem 'rack-livereload',  '~> 0.3.0'
  gem 'yajl-ruby',        '~> 1.1.0'

  gem 'better_errors',     '~> 0.3.2'
  gem 'binding_of_caller', '~> 0.7.1'
  gem 'clean_logger',      '~> 0.0.1'

  # Guard notifiers
  gem 'growl',              '~> 1.0.0' # Growl
end

group :development, :test do
  gem 'factory_girl_rails', '~> 4.1.0'
  gem 'jasmine',            '~> 1.2.0'
  gem 'rspec-rails',        '~> 2.12.0'
  gem 'mongoid-rspec'
  gem 'pry'
  gem 'timecop'
  gem 'json_spec'
end

group :test do
  gem 'database_cleaner', '~> 0.9.1'
  gem 'simplecov',        '~> 0.7.0', require: false
  gem 'rb-fsevent',       '~> 0.9.0', require: false
  gem 'guard',            '~> 1.5.0'
  gem 'guard-rspec',      '~> 2.1.0'
  gem 'guard-spork',      '~> 1.5.0'
  gem 'poltergeist',      '~> 1.1.0'
end