template "/etc/nginx/sites-enabled/yowcow.local.conf" do
  action :create
  source "templates/etc/nginx/sites-enabled/vh-default.conf.erb"
  variables(
    server_name:    "yowcow.local",
    document_root:  "/srv/yowcow.local/htdocs"
  )
end

directory "/srv/yowcow.local" do
  owner "vagrant"
  group "vagrant"
end

directory "/srv/yowcow.local/htdocs" do
  owner "vagrant"
  group "vagrant"
end

service 'nginx' do
  action [:enable, :reload]
end
