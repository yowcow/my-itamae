package 'nginx' do
  action :install
end

directory "/var/log/nginx" do
  action :create
  mode "0755"
end

node[:nginx][:hosts].each do |host|
  directory host[:root] do
    action :create
    mode "0777"
  end

  template "#{node[:nginx][:config_dir]}/#{host[:server_name]}.conf" do
    action :create
    mode "0644"
    source "templates/etc/nginx/sites-enabled/vh-default.conf.erb"
    variables(
      server_name: host[:server_name],
      root: host[:root]
    )
  end
end

service 'nginx' do
  action [:enable, :start]
end
