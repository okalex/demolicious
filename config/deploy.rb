set :application, 'docker-api'
set :scm, :git
set :repo_url, 'git@github.com:okalex/demolicious.git'
set :branch, 'master'
set :deploy_via, :remote_cache

set :deploy_to, '/var/factor/test'
set :ssh_options, {:forward_agent=>true, :keys=>[ENV['KEY_FILE']]}

set :user, "factor"
set :use_sudo, true

set :format, :pretty
set :log_level, :debug

namespace :deploy do

  task :setup do
    on roles(:app), in: :sequence, wait: 5 do
      sudo "mkdir -p /var/factor/test", as: 'factor'
      sudo "chmod -R 0777 /var/factor", as: 'factor'
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      dir = "/var/factor/test/current"
      sudo "pkill -f web.rb; true"
      sudo "BUNDLE_GEMFILE=#{dir}/Gemfile bundle exec rackup -p 80 -D #{dir}/config.ru"
    end
  end

  after :finishing, 'deploy:cleanup'

end
