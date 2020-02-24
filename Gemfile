source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.0'

gem 'rails', '~> 6.0'
gem 'pg', '~> 1.2', '>= 1.2.2'
gem 'puma', '~> 3.11'
gem 'sass-rails', '~> 6.0'
gem 'uglifier', '>= 1.3.0'
gem 'webpacker'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'octicons_helper', '~> 4.3'
gem 'graphql', '~> 1.10', '>= 1.10.3'
gem 'graphql-client', '~> 0.16.0'
gem 'chatops-controller', '~> 3.0', '>= 3.0.3'

group :development, :test do
  gem 'pry-byebug', '~> 3.6'
  gem 'dotenv-rails', '~> 2.2', '>= 2.2.2'
  gem 'factory_bot_rails', '~> 4.8', '>= 4.8.2'
  gem 'mocha', '~> 1.2', '>= 1.2.1'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
