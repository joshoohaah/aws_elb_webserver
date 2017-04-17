require 'chef/provisioning' # driver for creating machines
require 'chef/provisioning/aws_driver'

with_driver 'aws'
with_machine_options(bootstrap_options: {
                       image_id: 'ami-5e63d13e',
                       key_name: 'devops_rsa',
                       instance_type: 't2.micro',
                       key_path: '~/.ssh/devops_rsa',
                       chef_server: 'http://localhost:8889',
                       # security_groups: ['sg-a57fdbde'],
                       # region: "us-west-2",
                       # availability_zone: "c",
                       associate_public_ip_address: true
                     },
                     placement: {
                       availability_zone: 'c'
                     },
                     subnet_id: ['subnet-d3957888'])

machine 'test1' do
  :destroy
end
machine 'test2' do
  :destroy
end
