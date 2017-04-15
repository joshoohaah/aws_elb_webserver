group node['aws_elb_webserver']['group'] do
  action :create
end

user node['aws_elb_webserver']['user'] do
  gid node['aws_elb_webserver']['group']
  shell '/bin/bash'
  home "/home/#{node['aws_elb_webserver']['user']}"
  system true
  action :create
end
