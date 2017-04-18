require 'chef/provisioning'
require 'chef/provisioning/aws_driver'
with_driver 'aws'

with_machine_options(bootstrap_options: {
                         image_id: 'ami-5e63d13e',
                         key_name: 'devops_rsa',
                         instance_type: 't2.micro',
                         key_path: '~/.ssh/devops_rsa',
                         availability_zone: 'us-west-2c',
                         associate_public_ip_address: true
                     },
                     subnet_id: ['subnet-d3957888'])

machine 'httpd-1' do
    run_list ['aws_elb_webserver::create_user', 'aws_elb_webserver::configure_httpd', 'aws_elb_webserver::deploy_site']
end
machine 'httpd-2' do
    run_list ['aws_elb_webserver::create_user', 'aws_elb_webserver::configure_httpd', 'aws_elb_webserver::deploy_site']
end
machine 'nginx' do
    run_list ['aws_elb_webserver::create_user', 'aws_elb_webserver::configure_nginx', 'aws_elb_webserver::deploy_site']
end

load_balancer 'webserver-elb' do
    machines ['httpd-1', 'httpd-2', 'nginx']
    load_balancer_options(
        lazy do
            {
                availability_zones: ['us-west-2c'],
                listeners: [
                    {
                        instance_port: 8900,
                        instance_protocol: 'HTTP',
                        protocol: 'HTTP',
                        port: 80
                    },
                    {
                        instance_port: 8900,
                        instance_protocol: 'HTTP',
                        protocol: 'HTTP',
                        port: 443
                    }

                ],
                health_check: {
                    healthy_threshold: 2,
                    unhealthy_threshold: 4,
                    interval: 12,
                    timeout: 5,
                    target: 'HTTP:8900/'
                }
            }
        end
    )
    action :create
end
