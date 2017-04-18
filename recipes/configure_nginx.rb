node.default['nginx']['log_dir']              = node['aws_elb_webserver']['access_logs']
node.default['nginx']['user']                 = node['aws_elb_webserver']['group']
node.default['nginx']['group']                = node['aws_elb_webserver']['group']
node.default['nginx']['port']                 = node['aws_elb_webserver']['port']
node.default['nginx']['disable_access_log']   = false
node.default['nginx']['default_site_enabled'] = false # TODO: change to false when custom is deployed
node.default['nginx']['default_root']         = node['aws_elb_webserver']['docroot_dir']

# Creates folder for logs
directory node['aws_elb_webserver']['access_logs'] do
  owner node['aws_elb_webserver']['user']
  group node['aws_elb_webserver']['group']
  mode 0o0755
  recursive true
  action :create
end

# Creates directory for website
directory node['aws_elb_webserver']['docroot_dir'] do
  owner node['aws_elb_webserver']['user']
  group node['aws_elb_webserver']['group']
  mode 0o0755
  recursive true
  action :create
end

include_recipe 'chef_nginx::default'
