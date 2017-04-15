# apache deployment settings
default['aws_elb_webserver']['docroot_dir'] = '/var/www/html'

default['aws_elb_webserver']['user']   = 'webuser'
default['aws_elb_webserver']['group']  = 'webuser'
