service "nginx" do
  action :reload
end

http_request "/etc/nginx/conf.d/dhparam.pem" do
  url "https://ssl-config.mozilla.org/ffdhe2048.txt"
  mode "0644"
  not_if "test -f /etc/nginx/conf.d/dhparam.pem"
end

template "/etc/nginx/conf.d/ssl.conf" do
  action :create
  source "templates/nginx-ssl.conf.erb"
  mode   "0644"
  notifies :reload, "service[nginx]"
end
