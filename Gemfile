env = ENV["RAILS_ENV"] || 'development'
dbfile = File.expand_path("../config/database.yml", __FILE__)

group :production do
  gem 'pg'
end

source :rubygems

gem 'thin'
gem 'rails', '~> 3.0.10'
gem 'require_relative'
gem 'htmlentities'
gem 'json'
gem 'bluecloth', '~> 2.0.7'
gem 'coderay', '~> 0.9'
gem 'kaminari'
gem 'RedCloth', '~> 4.2.8'
gem 'addressable', '~> 2.1', :require => 'addressable/uri'
gem 'mini_magick', '~> 1.3.3', :require => 'mini_magick'
gem 'uuidtools', '~> 2.1.1'
gem 'flickraw-cached'
gem 'rubypants', '~> 0.2.0'
gem 'rake', '~> 0.9.2'
gem 'acts_as_list'
gem 'acts_as_tree_rails3'
gem 'recaptcha', :require => 'recaptcha/rails', :branch => 'rails3'

group :development, :test do
#  gem 'ruby-debug19'
  gem 'factory_girl', '~> 2.2'
  gem 'webrat'
  gem 'rspec-rails', '~> 2.0'
  gem 'simplecov', :require => false
  gem 'sqlite3'
  gem 'cucumber'
  gem 'cucumber-rails', :require => false
  gem 'cucumber-rails-training-wheels'
  gem 'database_cleaner'
  gem 'capybara'
end
