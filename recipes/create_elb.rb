# To use this cookbook run this command
# `chef-client -z /Users/joshuaschneider/healthcare-dev/cookbooks/aws_elb_webserver/recipes/create_elb.rb`
require 'chef/provisioning' # driver for creating machines
require 'chef/provisioning/aws_driver'

with_driver 'aws'
with_machine_options(bootstrap_options: {
                       image_id: 'ami-5e63d13e',
                       key_name: 'devops_rsa',
                       instance_type: 't2.micro',
                       key_path: '~/.ssh/devops_rsa',
                       # chef_server: 'http://localhost:8889',
                       # security_groups: ['sg-a57fdbde'],
                       # region: "us-west-2",
                       # availability_zone: "c",
                       associate_public_ip_address: true
                     },
                     placement: {
                       availability_zone: 'c'
                     },
                     subnet_id: ['subnet-d3957888'])

machine 'httpd-1' do
  # chef_server( :chef_server_url => 'http://localhost:8889')
  run_list ['aws_elb_webserver::create_user', 'aws_elb_webserver::deploy_site', 'aws_elb_webserver::configure_httpd']
end
machine 'httpd-2' do
  # chef_server( :chef_server_url => 'http://localhost:8889')
  run_list ['aws_elb_webserver::create_user', 'aws_elb_webserver::deploy_site', 'aws_elb_webserver::configure_httpd']
end
machine 'nginx' do
  # chef_server( :chef_server_url => 'http://localhost:8889')
  run_list ['aws_elb_webserver::create_user', 'aws_elb_webserver::deploy_site', 'aws_elb_webserver::configure_nginx']
end

# m2 = machine 'test2'

load_balancer 'my-elb' do
  machines ['httpd-1', 'httpd-2', 'nginx']
  # machines ['test1', m2]
  load_balancer_options( # subnets: ['subnet-d3957888'],
    availability_zones: ['us-west-2c'],
    # security_groups: ['sg-a57fdbde'],
    listeners: [
      {
        instance_port: 8900,
        protocol: 'HTTP',
        instance_protocol: 'HTTP',
        port: 8900
      }
    ],
    health_check: {
      healthy_threshold: 2,
      unhealthy_threshold: 4,
      interval: 12,
      timeout: 5
      # target: 'HTTPS:443/_status'
    }
  )
  action :create
end

# require 'chef/provisioning'  # driver for creating machines
# # provisioner = get_setting("CHEF_PROFILE", "abcd-environments")
# require "chef/provisioning/aws_driver"
#
# load_balancer 'test-elb-from-prov' do
#   # driver "aws:abcd-environments"
#   machines ['webappsadm001.da.abcd']
#   load_balancer_options   availability_zones: ['us-west-2c'],
#   listeners: [{
#     # required
#     protocol: :http,
#     # required
#     port: 80,
#     instance_protocol: :http,
#     # required
#     instance_port: 10262,
#     }],
#   subnets: ['subnet-d3957888'],
#
#     health_check:
#     [{
#       target: "TCP:10262",
#       interval: 30,
#       timeout: 5,
#       unhealthy_threshold: 2,
#       healthy_threshold: 10
#     }]
#
# end
