template "/etc/nginx/conf.d/ssl.conf" do
  action :create
  source "templates/nginx-ssl.conf.erb"
  mode   "0644"
  notifies :reload, "service[nginx]"
end
