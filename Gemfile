source 'https://rubygems.org'
ruby '2.0.0'
#ruby-gemset=railstutorial_rails_4_0
gem 'coffee-rails','~> 4.0.1'

gem 'sass-rails'
gem 'rails', '4.0.0'
#gem 'bootstrap-sass', '2.3.2.0'
gem 'bcrypt-ruby', '3.0.1'
gem 'geocoder'
gem 'nifty-generators'
gem 'carrierwave'
gem 'faker', '1.1.2'
gem 'will_paginate', '~> 3.0.5'
gem 'will_paginate-bootstrap'
gem 'anjlab-bootstrap-rails', :require => 'bootstrap-rails',
                          :github => 'anjlab/bootstrap-rails',
                           :branch => '3.0.0'
#gem 'bootstrap-datetimepicker-rails'

#agem 'activerecord-reputation-system', require: 'reputation_system'
#gem 'protected_attributes' # added so that we can use repuation system gem
gem 'activerecord-reputation-system', github: 'NARKOZ/activerecord-reputation-system', branch: 'rails4'
gem 'mapbox-rails'
gem 'pg'
#gem 'sqlite3'
#gem 'taps'
gem "fog", "~> 1.3.1"
group :development, :test do
  #gem 'sqlite3', '1.3.8'
  gem 'rspec-rails', '2.13.1'
end

group :test do
  gem 'selenium-webdriver', '2.35.1'
  gem 'capybara', '2.1.0'
end
group :production, :test do
  gem 'rails_12factor','0.0.2'
end
gem 'uglifier', '2.1.1'
gem 'jquery-rails', '3.0.4'
gem 'turbolinks', '1.1.1'
gem 'jbuilder', '1.0.2'

group :doc do
  gem 'sdoc', '0.3.20', require: false
end



gem "mocha", group: :test
