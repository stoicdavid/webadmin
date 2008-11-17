require'mongrel_cluster/recipes' 


set :domain, "deploy@172.16.90.100"
set :application, "webadmin"
set :repository,  "git://github.com/stoicdavid/webadmin.git"
set :deploy_to, "/var/www/apps/#{application}"
set :ssh_options, {:port => 7000}
set :mongrel_conf, "#{current_path}/config/mongrel_cluster.yml"
set :monit_group, 'mongrel'
role :app, domain
role :web, domain
role :db,  domain, :primary => true


# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
# set :deploy_to, "/var/www/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
set :scm, :git

namespace :deploy do
  %w(restart stop start).each do |command|
    task command.to_sym, :roles => :app do
      sudo "/usr/sbin/monit #{command} all -g #{monit_group}"
    end
  end
end

task :restart, :roles => :app do
end

task :after_update_code, :roles => [:web, :db, :app] do
  run "chmod 755 #{release_path}/public -R" 
end