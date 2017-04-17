# To use this cookbook run this command
# `chef-client -z /Users/joshuaschneider/healthcare-dev/cookbooks/aws_elb_webserver/recipes/create_elb.rb`
require 'chef/provisioning'  # driver for creating machines
require 'chef/provisioning/aws_driver'

with_driver 'aws'
  with_machine_options({
    :bootstrap_options => {
      image_id: 'ami-5e63d13e',
      key_name: 'devops_rsa',
      instance_type: 't2.micro',
      key_path: "~/.ssh/devops_rsa",
      chef_server: 'http://localhost:8889',
      # security_groups: ['sg-a57fdbde'],
      # region: "us-west-2",
      # availability_zone: "c",
      associate_public_ip_address: true
    },
   :placement => {
     availability_zone: "c"
   },
   subnet_id: ['subnet-d3957888']
})

# machine 'myinstance' do
#   action :allocate
# end
#
# load_balancer 'my_load_balancer' do
#   machines ['myinstance']
# end

#
# machine 'my_machine' do
#   driver 'aws'
#   machine_options({
#         bootstrap_options: {
#           region: 'us-west-2',
#           subnet_id: 'subnet-d3957888',
#           security_group_ids: ['sg-a57fdbde'],
#           key_name: 'devops_rsa',
#           image_id: 'ami-5e63d13e',
#           key_path: "~/.ssh/devops_rsa"
#         }
#       }
#   )
# end

machine 'test1' do
  chef_server( :chef_server_url => 'http://localhost:8889')
end
m2 = machine 'test2'

load_balancer "my_elb" do
  machines ['test1', m2]
  load_balancer_options({
    subnets: ['subnet-d3957888'],
    availability_zones: ['us-west-2c'],
    security_groups: ['sg-a57fdbde'],
    listeners: [
      {
          instance_port: 8080,
          protocol: 'HTTP',
          instance_protocol: 'HTTP',
          port: 80
      },
      {
          instance_port: 8080,
          protocol: 'HTTPS',
          instance_protocol: 'HTTP',
          port: 443,
      }
    ],
    health_check: {
      healthy_threshold: 2,
      unhealthy_threshold: 4,
      interval: 12,
      timeout: 5,
      target: 'HTTPS:443/_status'
    }
  })
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
