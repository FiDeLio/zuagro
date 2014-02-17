# setup multistage
set :stages, %w(staging production)
set :default_stage, "staging"


require 'capistrano/ext/multistage'

set :application, "ZUAGRO"
set :repository,  "git@github.com:FiDeLio/zuagro.git"

set :scm, :git

set :user, "root"

set :deploy_to, "/var/www/zuagro"

set :use_sudo, false

set :deploy_via, :copy
set :copy_exclude, [".git"]
set :ssh_options, forward_agent: true
set :unicorn_pid, "#{current_path}/tmp/pids/unicorn.pid"

#ssh_options[:keys] = ["~/.ssh/ccni_key.pem"]

after "deploy:restart", "unicorn:restart"
after "deploy:create_symlink", "assets:precompile"

# Unicorn
namespace :unicorn do
  def run_unicorn
    "cd #{current_path} ; RAILS_ENV=#{rails_env} bundle exec unicorn_rails -c config/unicorn.rb -D"
  end

  desc "Zero-downtime restart of Unicorn"
  task :restart, except: { no_release: true } do
    cmd = "if [ -f #{unicorn_pid} ]; then kill -s USR2 `cat #{unicorn_pid}`; else #{run_unicorn} ; fi"
    run cmd
  end

  desc "Start unicorn"
  task :start, except: { no_release: true } do
    run run_unicorn
  end

  desc "Stop unicorn"
  task :stop, except: { no_release: true } do
    run "if [ -f #{unicorn_pid} ]; then kill -s QUIT `cat #{unicorn_pid}` ; fi"
  end
end


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