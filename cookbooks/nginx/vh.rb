service "nginx"

node[:nginx][ENV["ENVNAME"]][:vh].each do |vh|

  directory "/srv/#{vh[:server_name]}" do
    action :create
  end

  template "/etc/nginx/sites-enabled/#{vh[:server_name]}.conf" do
    action :create
    source "templates/nginx-vh.conf.erb"
    mode "0644"
    variables(server_name: vh[:server_name], listen: vh[:listen])
    notifies :reload, "service[nginx]"
  end
end
