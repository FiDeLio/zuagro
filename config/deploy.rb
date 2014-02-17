# setup multistage
set :stages, %w(staging production)
set :default_stage, 'staging'
require 'capistrano/ext/multistage'
require 'capistrano-unicorn'
set :application, 'ZUAGRO'

#server
set :user, 'zuagro'
set :deploy_to, '/var/www/zuagro'
set :use_sudo, false

#git
set :repository,  'git@github.com:FiDeLio/zuagro.git'
set :branch, 'master'
set :scm, :git
set :repository_cache, 'git_cache'
set :deploy_via, :remote_cache
set :ssh_options, { :forward_agent => true }

set :unicorn_pid, "#{current_path}/tmp/pids/unicorn.pid"

after 'deploy:create_symlink', 'assets:precompile'
after 'deploy:restart', 'unicorn:reload'
after 'deploy:restart', 'unicorn:restart'
after 'deploy:restart', 'unicorn:duplicate'