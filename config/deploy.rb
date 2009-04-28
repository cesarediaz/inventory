default_run_options[:pty] = true
#ssh_options[:keys] = %w(/home/some_user/.ssh/id_dsa)
set :repository,  "git://github.com/cesarediaz/inventory.git"
set :application, "inventory"
set :scm, "git"
set :user, "root"
set :use_sudo, false


set :branch, "master"
# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/var/www/apps/#{application}"
set :shared_path, "#{deploy_to}/shared"

# If you aren't using Subversion to manage your source code, specifyl
# your SCM below:
# set :scm, :subversion


server "www.my_server_domain.com", :app, :web, :db, :primary => true

desc "Crea simlinks de logs y archivo de configuracion"
deploy.task :create_links, :roles => :app do

  run "rm -rf #{shared_path}/log; rm -rf #{latest_release}/log"
  run "mkdir #{shared_path}/log"
  run "touch #{shared_path}/log/development.log; touch #{shared_path}/log/production.log"
  run "ln -s #{shared_path}/log #{latest_release}/log"
  run "chmod 775 #{latest_release}/log"
  run "chmod 666 #{latest_release}/log/*"

  run "cd #{latest_release} && rm config/database.yml"
  run "ln -s #{shared_path}/system/database.yml #{latest_release}/config/database.yml"
  run "chmod 644 #{latest_release}/config/database.yml"



end

after "deploy:finalize_update", "deploy:create_links"


 namespace :deploy do

  task :start, :roles => :app do
    run "/etc/init.d/apache2 restart"
  end

  task :stop, :roles => :app do
    # Do nothing.
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    run "/etc/init.d/apache2 restart"
  end
end

######################################################################################
# AUTH KEYS

after "deploy:update_code", "auth:site_key_symlink"

namespace :auth do
  desc "Make symlink for site_key.rb (restfull authentication)"
  task :site_key_symlink  do
    run "ln -nfs #{shared_path}/system/site_keys.rb
           #{release_path}/config/initializers/site_keys.rb"
  end
end
