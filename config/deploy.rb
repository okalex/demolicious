set :application, 'docker-api'
set :scm, :git
set :repo_url, 'git@github.com:okalex/demolicious.git'
set :branch, 'master'
set :deploy_via, :remote_cache

set :deploy_to, '/var/factor/test'
set :ssh_options, {:forward_agent=>true, :keys=>[ENV['KEY_FILE']]}

set :user, "factor"

set :format, :pretty
set :log_level, :debug

namespace :deploy do

  task :setup do
    on roles(:app), in: :sequence, wait: 5 do
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      sudo "pkill -f web.rb; true"
      sudo "cd /var/factor/test/current/ && ruby web.rb"
    end
  end

  after :finishing, 'deploy:cleanup'

end
