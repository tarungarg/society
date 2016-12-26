lock '3.7.0'

set :application, 'society'
set :repo_url, 'ssh://git@bitbucket.org/tarun402/society.git'
set :scm, :git
set :scm_verbose, true
set :deploy_to, "/var/www/#{fetch(:application)}_#{fetch(:stage)}"
set :deploy_via, :remote_cache

set :pty, false
set :use_sudo, false
set :ssh_options, forward_agent: true

set :bundle_without, 'development test'
set :linked_files, fetch(:linked_files, []).push('config/database.yml')
set :linked_dirs, %w(log tmp/cache tmp/uploads tmp/sockets tmp/pids public/system public/uploads)

set :puma_threads,    [0, 8]
set :puma_workers,    0
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log,  "#{release_path}/log/puma.access.log"
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true

namespace :deploy do
  desc 'Initial deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # invoke 'puma:restart'
    end
  end

  after :finishing, :cleanup
  after :publishing, :restart
end

# after 'deploy:finished', 'newrelic:notice_deployment'

desc 'Launch remote rails console'
task :console do
  on primary(:app) do
    within current_path do
      with rails_env: fetch(:rails_env) do
        interact(:rails, :console)
      end
    end
  end
end

desc 'Launch remote rails dbconsole'
task :dbconsole do
  on primary(:app) do
    within current_path do
      with rails_env: fetch(:rails_env) do
        interact(:rails, :dbconsole, '--include-password')
      end
    end
  end
end

desc 'Open ssh connection app server'
task :ssh do
  on primary(:app) do
    within current_path do
      interact(:bash)
    end
  end
end
