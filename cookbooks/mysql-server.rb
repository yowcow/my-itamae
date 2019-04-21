%w{
  mysql-server
}.each do |pkg|
  package pkg
end

service "mysql" do
  action [:enable, :restart]
end

template "/etc/mysql/conf.d/server.cnf" do
  action   :create
  source   "mysql-common/templates/server.cnf.erb"
  mode     "0644"
  notifies :restart, "service[mysql]"
end
