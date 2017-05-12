execute 'update apt-get' do
  command ' apt-get update'
  action :run
end
