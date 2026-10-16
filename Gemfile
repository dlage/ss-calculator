source 'https://rubygems.org'

ruby '~> 3.4.0'
gem 'rails', '~> 8.1.4'
gem 'pg', '~> 1.6'
gem 'puma', '~> 7.1'
gem 'sprockets-rails'
# SassC/FFI is needed to compile RailsAdmin styles, not to serve the app.
group :assets do
  gem 'sassc-rails'
end
gem 'jsbundling-rails', '~> 1.3'
gem 'cssbundling-rails', '~> 1.4'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.14'
gem 'bootsnap', require: false

gem 'rails_admin', '~> 3.3'
gem 'rails_admin_import', '~> 3.0'
gem 'devise', '~> 5.0'
gem 'omniauth-github'
gem 'omniauth-openid'
gem 'rexml' # OpenID uses the XML library extracted from Ruby's standard library.
gem 'omniauth-google-oauth2'
gem 'omniauth-facebook'
gem 'omniauth-rails_csrf_protection'

group :development, :test do
  gem 'debug', platforms: :mri, require: 'debug/prelude'
end

group :development do
  gem 'web-console'
  gem 'listen', '~> 3.9'
  gem 'capistrano', '~> 3.19', require: false
  gem 'capistrano-rails', '~> 1.6', require: false
  gem 'capistrano-passenger', require: false
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
end

gem 'tzinfo-data', platforms: [:windows, :jruby]
