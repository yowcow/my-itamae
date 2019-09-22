service "nginx" do
  action :reload
end

template "/etc/nginx/conf.d/security.conf" do
  action :create
  source "templates/nginx-security.conf.erb"
  mode   "0644"
  notifies :reload, "service[nginx]"
end
