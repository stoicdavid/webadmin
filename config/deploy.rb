require'mongrel_cluster/recipes' 


set :application, "webadmin"
set :repository,  "http://neurolab-webadmin.googlecode.com/svn/trunk/webadmin"
set :deploy_to, "/Library/Rails/#{webadmin}" 
set :mongrel_conf, "#{current_path}/config/mongrel_cluster.yml"


# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
# set :deploy_to, "/var/www/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion

role :app, "neurolab.homelinux.org"
role :web, "neurolab.homelinux.org"
role :db,  "neurolab.homelinux.org", :primary => true

set :user, 'webadmin'
set :scm_username, "svnusername" 
set :server, 'neurolab.railsplayground.net'
set :application, 'webadmin'
set :applicationdir, 'webadmin' 
set :repository, "http://neurolab-webadmin.googlecode.com/svn/trunk/webadmin" 
role :web, server
role :app, server
role :db,  server, :primary => true

set :deploy_to, "/home/#{webadmin}/#{webadmin}" 

task :restart, :roles => :app do
end

task :after_update_code, :roles => [:web, :db, :app] do
  run "chmod 755 #{release_path}/public -R" 
end