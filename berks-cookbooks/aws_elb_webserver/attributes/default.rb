# Default user for webserver
default['aws_elb_webserver']['user']        = 'webuser'
default['aws_elb_webserver']['group']       = 'webuser'

# Default Port for webservers
default['aws_elb_webserver']['port']        = 8900

# Default folder structures for webserver machines
default['aws_elb_webserver']['docroot_dir'] = '/var/www/html'
default['aws_elb_webserver']['access_logs'] = '/var/log/tdcustom/accesslogs/'

# Oracle java download defaults
default['java']['oracle']['accept_oracle_download_terms'] = true
default['java']['install_flavor']                         = 'oracle'
default['java']['jdk_version']                            = '8'
