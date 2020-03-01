source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.2'

gem 'aasm'
gem 'activerecord-import'
gem 'bitly', '~> 2.0.0.beta.1'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'cancancan'
gem 'devise'
gem 'devise_token_auth'
gem 'friendly_id'
gem 'haml'
gem 'jbuilder', '~> 2.7'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'rack-cors'
gem 'rails', '~> 6.0.0'
gem 'rescue_groups', github: 'petparent/rescue_groups', branch: 'petparent-raw-data'
gem 'sass-rails', '~> 5'
gem 'sidekiq'
gem 'simple_form'
gem 'simple_segment'
gem 'turbolinks', '~> 5'
gem 'versionist'
gem 'webpacker', '~> 4.0'
gem 'whenever', require: false
gem 'faker', git: 'https://github.com/faker-ruby/faker.git', branch: 'master'

group :development, :test do
  gem 'pry'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'spring'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'capistrano'
  gem 'capistrano-rails'
  gem 'capistrano-bundler'
  gem 'capistrano-rbenv'
  gem 'capistrano3-puma'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner-active_record'
  gem 'factory_bot_rails'
  gem 'minitest-rails', '~> 6.0.0'
  gem 'minitest-reporters', '>= 0.5.0'
  gem 'shoulda'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
  gem 'webmock'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
