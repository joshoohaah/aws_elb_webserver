# This recipe is for deploying the 'hello world' files for the default webpage

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
