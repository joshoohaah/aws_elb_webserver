# node.default['nginx']['conf_template'] =
# node.default['nginx']['conf_cookbook'] =
node.default['nginx']['log_dir'] = node['aws_elb_webserver']['access_logs']
# node.default['nginx']['log_dir_perm'] - Permissions for nginx logs folder.
node.default['nginx']['user'] = node['aws_elb_webserver']['group']
node.default['nginx']['group'] = node['aws_elb_webserver']['group']
node.default['nginx']['port'] = node['aws_elb_webserver']['port']
node.default['nginx']['disable_access_log'] = false
node.default['nginx']['default_site_enabled'] = true # TODO: change to false when custom is deployed
node.default['nginx']['default_root'] = node['aws_elb_webserver']['docroot_dir']

include_recipe 'chef_nginx::default'
#
# nginx_site 'default' do
#   enable false # legacy "action"
# end

# nginx_site 'Enable the redirect_site' do
#   template 'site.erb'
#   name 'redirect_site'
#   action :enable # modern action
# end
