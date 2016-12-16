package 'nginx' do
  action :install
end

node[:nginx][:hosts].each do |host|
  directory host[:root] do
    action :create
    mode "0777"
  end

  template "/etc/nginx/sites-enabled/#{host[:server_name]}.conf" do
    action :create
    mode "0644"
    source "templates/etc/nginx/sites-enabled/vh-default.conf.erb"
    variables(
      server_name: host[:server_name],
      root: host[:root],
      proxy_port: host[:proxy_port]
    )
  end
end

service 'nginx' do
  action [:enable, :start, :reload]
end
