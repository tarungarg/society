require ::File.expand_path('../../config/environment',  __FILE__)
Rails.application.eager_load!

require 'action_cable/process/logging'

run ActionCable.server

# run server
# bundle exec puma -p 28080 cable/config.ru
