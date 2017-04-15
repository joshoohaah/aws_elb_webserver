# apache deployment settings

default['aws_elb_webserver']['user']        = 'webuser'
default['aws_elb_webserver']['group']       = 'webuser'

default['aws_elb_webserver']['port']        = 8900


default['aws_elb_webserver']['docroot_dir'] = '/var/www/html'
default['aws_elb_webserver']['access_logs'] = '/var/log/tdcustom/accesslogs/'


default['java']['oracle']['accept_oracle_download_terms'] = true
default['java']['install_flavor']= 'oracle'
default['java']['jdk_version'] = '8'
