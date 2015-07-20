package 'nginx' do
  action :install
end

service 'nginx' do
  action [:enable, :start]
end

file "/etc/nginx/sites-enabled/default" do
  action :delete
end

template "/etc/nginx/sites-enabled/default.conf" do
  action :create
  source "templates/etc/nginx/sites-enabled/default.conf.erb"
end

service 'nginx' do
  action [:enable, :reload]
end
