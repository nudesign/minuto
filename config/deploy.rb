require 'rvm/capistrano'
require 'bundler/capistrano'

server '54.235.145.249', :web, :app

set :application, 'newcreators.com.br'
set :repository,  'git@github.com:nudesign/newcreators.git'
set :user,        'ubuntu'
set :deploy_to,   "/home/#{user}/rails_apps/#{application}"
set :use_sudo,    false
set :scm,         :git

after 'deploy:update_code', 'deploy:symlink_shared'
after 'deploy:update',      'deploy:create_indexes'
after 'deploy:restart',     'deploy:cleanup'

namespace :deploy do
  task :start do
    run "cd #{current_path} && bundle exec unicorn -c config/unicorn.rb -E #{rails_env} -D"
  end

  task :stop do
    run "cd #{current_path} && kill -s QUIT `cat tmp/pids/unicorn.pid`"
  end

  task :restart, :roles => :app, :except => { :no_release => true } do
    run "kill -s USR2 `cat #{current_path}/tmp/pids/unicorn.pid`"
  end

  desc 'Symlink shared configs and folders on each release.'
  task :symlink_shared do
    run "ln -s #{shared_path}/public/uploads #{release_path}/public/uploads"
  end

  desc 'Create indices on MongoDB'
  task :create_indexes do
    run "cd #{current_path} && bundle exec rake db:mongoid:create_indexes RAILS_ENV=#{rails_env}"
  end

  namespace :db do
    desc 'Populates the Production Database'
    task :seed do
      run "cd #{current_path}; bundle exec rake db:seed RAILS_ENV=#{rails_env}"
    end
  end
end
