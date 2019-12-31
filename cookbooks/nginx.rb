%w{
  nginx
  nginx-common
}.each do |pkg|
  package pkg
end

service "nginx" do
  action [:enable, :reload]
end

template "/etc/nginx/nginx.conf" do
  action :create
  source "nginx/templates/nginx.conf.erb"
  mode "0644"
  notifies :reload, "service[nginx]"
end

template "/etc/logrotate.d/nginx" do
  action :create
  source "nginx/templates/logrotate/nginx.erb"
  mode "0644"
end

include_recipe "nginx/ssl.rb"
include_recipe "nginx/compress.rb"
include_recipe "nginx/security.rb"
