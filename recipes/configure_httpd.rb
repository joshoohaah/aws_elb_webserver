include_recipe 'aws_elb_webserver::create_user'

directory node['aws_elb_webserver']['access_logs'] do
  owner node['aws_elb_webserver']['user']
  group node['aws_elb_webserver']['group']
  mode 00755
  recursive true
  action :create
end

httpd_service 'default' do
  run_group node['aws_elb_webserver']['group']
  run_user node['aws_elb_webserver']['user']
  listen_ports ["#{node['aws_elb_webserver']['port']}"]
  action [:create, :start]
end

httpd_config 'default' do
  source 'site.conf.erb'
  notifies :restart, 'httpd_service[default]'
  action :create
end

# file "#{node['aws_elb_webserver']['docroot_dir']}/index.html" do
#   content 'hello there\n'
#   action :create_if_missing
#   notifies :restart, 'httpd_service[default]', :delayed
# end


# httpd_config 'default' do
#   source 'site.conf.erb'
#   notifies :restart, 'httpd_service[default]', :delayed
#   not_if { File.exist?('/etc/httpd-default/conf.d/default.conf') }
# end
