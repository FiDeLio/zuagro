# setup multistage
set :stages, %w(staging production)
set :default_stage, 'staging'
require 'capistrano/ext/multistage'
require 'capistrano-unicorn'
set :application, 'ZUAGRO'
#git
set :repository,  'git@github.com:FiDeLio/zuagro.git'
set :branch, 'master'
set :scm, :git
set :repository_cache, 'git_cache'
set :deploy_via, :remote_cache
set :ssh_options, { :forward_agent => true }
#server
set :user, 'zuagro'
set :deploy_to, '/var/www/zuagro'
set :use_sudo, false

set :unicorn_pid, "#{current_path}/tmp/pids/unicorn.pid"

after "deploy:create_symlink", "assets:precompile"
after 'deploy:restart', 'unicorn:reload'    # app IS NOT preloaded
after 'deploy:restart', 'unicorn:restart'   # app preloaded
after 'deploy:restart', 'unicorn:duplicate'

# Assets
namespace :assets do
  desc "Precompile assets locally and then rsync to app servers"
  task :precompile, only: { :primary => true } do
    run_locally "mkdir -p public/__assets; mv public/__assets public/assets;"
    run_locally "bundle exec rake assets:precompile;"
    servers = find_servers roles: [:app], except: { :no_release => true }
    servers.each do |server|
      run_locally "rsync  -rave  'ssh -i /Users/fidel/.ssh/zuagro' ./public/assets/ #{user}@#{server}:#{current_path}/public/assets/;"
    end
    run_locally "mv public/assets public/__assets"
  end
end
