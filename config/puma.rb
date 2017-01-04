#!/usr/bin/env puma

directory '/var/www/society_production/current'
rackup '/var/www/society_production/current/config.ru'
environment 'production'

pidfile '/var/www/society_production/shared/tmp/pids/puma.pid'
state_path '/var/www/society_production/shared/tmp/pids/puma.state'
stdout_redirect '/var/www/society_production/current/log/puma.error.log', '/var/www/society_production/current/log/puma.access.log', true

threads 0, 8

bind 'unix:///var/www/society_production/shared/tmp/sockets/society-puma.sock'

workers 0

preload_app!

on_restart do
  puts 'Refreshing Gemfile'
  ENV['BUNDLE_GEMFILE'] = '/var/www/society_production/current/Gemfile'
end

on_worker_boot do
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Base.establish_connection
  end
end
