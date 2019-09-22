service "nginx"

template "/etc/nginx/conf.d/compress.conf" do
  action :create
  source "templates/nginx-compress.conf.erb"
  mode   "0644"
  notifies :reload, "service[nginx]"
end
