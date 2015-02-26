gem 'bootstrap-sass'
gem 'autoprefixer-rails'

gem 'slim-rails'
gem 'figaro'

gem_group :development, :test do
  gem 'quiet_assets'
  gem 'factory_girl_rails'
  gem 'faker'
end

gem_group :test do
  gem 'rspec-rails'
end

run 'bundle install'

generate :controller, 'home', 'index'
gsub_file 'config/routes.rb', "get 'home/index'", "root 'home#index'"

# Generate rspec
generate 'rspec:install'

run 'figaro install'

# Ignore sensitive data
append_file '.gitignore', 'config/database.yml'
run 'cp config/database.yml config/example_database.yml'

# Add assets
remove_file 'app/assets/stylesheets/application.css'
create_file 'app/assets/stylesheets/variables.sass'
create_file 'app/assets/stylesheets/bootstrap_custom.sass'
create_file 'app/assets/stylesheets/application.sass' do
  <<-FILE
@import "variables"
@import "bootstrap-sprockets"
@import "bootstrap"

@import "bootstrap_custom"
  FILE
end
gsub_file 'app/assets/javascripts/application.js', '//= require_tree .', '//= require bootstrap-sprockets'

# Add git
git :init
git add: '.', commit: '-m "initial project"'
