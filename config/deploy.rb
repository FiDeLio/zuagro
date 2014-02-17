# setup multistage
set :stages, %w(staging production)
set :default_stage, 'staging'
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

