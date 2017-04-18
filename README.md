# aws_elb_webserver-cookbook

The purpose of this cookbook is to deploy 2 different style web-servers in this cookbook.  
There is also an option to deploy in `standalone` mode using `chef-client --local-mode` which will deploy 3 machines and put them behind a load balancer.
## Supported Platforms

Ubuntu linux platform

## Usage
### using chef-provisioning
To run in `chef-client --local-mode` the following assumptions are made:
  1. `devops_rsa` key pair is installed on local machine (`~/.ssh/devops_rsa`) and in the correct aws cloud region
  1. command line session already registered to aws
  1. chefdk software package installed
  1. `berks vendor` on this cookbook and put that output into your local chef repo cookbook folder  `cp -R berks-cookbooks/* ~/<your chef repo>/cookbooks`
     1. if you don't have a chef repo make one!  `chef generate <your chef repo>`
  1. run the webserver/elb deployment example using `chef-client --local-mode aws-deploy.rb`
### using test-kitchen
   1. Locally
      1. set environment variable to point to correct kitchen file `export KITCHEN_YAML=.kitchen.yml`
      1. `kitchen converge` will deploy 3 webserver boxes locally.
   1. in AWS
      1. set environment variable to point to correct kitchen file `export KITCHEN_YAML=.kitchen.cloud.yml`
      1. `kitchen converge` will deploy 3 webserver boxes in aws.

## Recipes
### aws_elb_webserver::default
does nothing.  This recipe is empty
### aws_elb_webserver::create_user
Deploys the standard user the web-servers will use to run their services.
### aws_elb_webserver::deploy_site
Deploys the standard site the web-servers will point to.
### aws_elb_webserver::configure_httpd
Deploys httpd web service and configures it to run.
### aws_elb_webserver::configure_nginx
Deploys nginx web service and configures it to run.

## License and Authors

Author::(<josh.schneider@ge.com>)
