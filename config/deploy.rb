#require'mongrel_cluster/recipes' 

set :domain, "deploy@172.16.90.100"
#set :domain, "deploy@laboratorio.gotdns.com"
set :application, "webadmin"
set :repository,  "git://github.com/stoicdavid/webadmin.git"
set :deploy_via, :remote_cache
set :deploy_to, "/var/www/apps/#{application}"
set :copy_exclude, [".git","/public/usuario","/public/doctor"]
set :ssh_options, {:port => 7777}
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

task :after_update_code, :roles => [:web, :db, :app] do
  run "chmod 755 #{release_path}/public -R" 
end


after 'deploy:update_code', 'deploy:link_images' 
namespace(:deploy) do 
  task :link_images do 
    run "cd #{release_path} && ln -nfs #{shared_path}/usuario/imagen #{release_path}/public/usuario/imagen"
    run "cd #{release_path} && ln -nfs #{shared_path}/doctor/imagen #{release_path}/public/doctor/imagen" 
  end 
end
