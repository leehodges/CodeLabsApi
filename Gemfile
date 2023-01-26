source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.0'

# ================== The BASICS ========================
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 7.0.4.1'
# Use postgresql as the database for Active Record
gem 'pg', '>= 1.1'
# Use Puma as the app server
gem 'puma', '>= 5.0'
# Specify version, per dependabot
gem 'activesupport', '>= 6.1.3.1'
# Use Redis adapter to run Action Cable in production
gem 'redis', '>= 4.0'
# Use Active Model has_secure_password
gem 'bcrypt', '>= 3.1.7'
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false


# ======================== RACK GEMS =======================
# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-attack'
gem 'rack-cors'

# ======================== Background Jobs Gems ========================
gem 'sidekiq'
gem 'sidekiq-scheduler'

# ======================== Communication Gems ========================
gem 'sendgrid-ruby'
gem 'twilio-ruby'

# ======================== JSON Serialization Gems ========================
gem 'blueprinter'
gem 'oj'
gem 'oj_mimic_json'

# ======================== Miscellaneous Gems ========================
gem 'to_bool', '~> 2.0'
gem 'faker', :git => 'https://github.com/faker-ruby/faker.git', :branch => 'main'

# ==================== Documentation Gems ====================
gem 'rswag'

# ==================== rSwag Gems =======================
gem 'rspec-rails'
gem 'rswag-specs'



# ======================== Development Gems ========================
group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]

  gem 'factory_bot_rails'
end

group :development do
  gem 'annotate'
  gem 'listen', '~> 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  # The commented out gem below speeds up spring, but is currently not compatible with latest version of Rails, it should be compatible shortly,
  # check projects github to subscribe to updates
  # gem 'spring-watcher-listen'

end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
# If Platform Windows, monitor window directory changes
gem 'wdm', '>= 0.1.0' if Gem.win_platform?
