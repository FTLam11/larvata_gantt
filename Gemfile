source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Declare your gem's dependencies in larvata_gantt.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use a debugger
# gem 'byebug', group: [:development, :test]

gem 'activerecord-import'
gem 'dotenv-rails'
gem 'bootsnap', require: false

group :development, :test do
  gem 'awesome_print'
  gem 'pry'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'factory_bot_rails'
end

group :test do
  gem 'faker'
end

group :development do
  gem 'spring'
  gem 'spring-commands-rspec'
end
