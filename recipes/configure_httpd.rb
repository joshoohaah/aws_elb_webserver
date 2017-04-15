include_recipe 'aws_elb_webserver::create_user'

httpd_service 'default' do
  run_group node['aws_elb_webserver']['group']
  run_user node['aws_elb_webserver']['user']
  listen_ports ['80', '8900']
  action [:create, :start]
end

httpd_config 'default' do
  source 'site.conf.erb'
  notifies :restart, 'httpd_service[default]'
  action :create
end
directory "#{node['aws_elb_webserver']['docroot_dir']}/img" do
  recursive true
  action :create
end
cookbook_file "#{node['aws_elb_webserver']['docroot_dir']}/img/josh_approved.gif" do
  source 'josh_approved.gif'
  # owner 'root'
  # group 'root'
  # mode 00644
end
template "#{node['aws_elb_webserver']['docroot_dir']}/index.html" do
  source 'index.html.erb'
  # owner 'root'
  # group 'root'
  # mode 00744
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
