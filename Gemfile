source 'https://rubygems.org'

# Specify your gem's dependencies in cucumber-blanket.gemspec
gemspec

gem "bundler", "~> 1.3"
gem "rake"
gem 'file-utils'
gem 'haml'

group :development, :test do
  gem "pry"
end

group :test do
  gem 'coveralls', require: false
  gem "rspec", "~> 2.14"
  gem "guard-rspec"
end
