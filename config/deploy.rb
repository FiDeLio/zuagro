# setup multistage
set :stages, %w(staging production)
set :default_stage, 'staging'
require 'capistrano/ext/multistage'
require 'capistrano-unicorn'
set :application, 'ZUAGRO'


#server
set :domain, 'zuagro.com'
set :user, 'zuagro'
set :use_sudo, false
set :deploy_to, '/var/www/zuagro'

#local
set :local_repository,  '~/Documents/vagrant/ruby/zuagro/.git'

#git
set :repository,  'git@github.com:FiDeLio/zuagro.git'
set :branch, 'master'
set :scm, :git
set :repository_cache, 'git_cache'
set :deploy_via, :remote_cache
default_run_options[:pty] = true
ssh_options[:forward_agent] = true



after 'deploy', 'deploy:bundle_gems'
after 'deploy:bundle_gems', 'deploy:restart'
after 'deploy:update_code', 'deploy:migrate'
after 'deploy', 'deploy:cleanup'
