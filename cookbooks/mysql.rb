%w{
  mysql-server
  mysql-client
  mysql-common
}.each do |pkg|
  package pkg
end

charset = "utf8mb4"

template "/etc/mysql/mysql.conf.d/mysqld_utf8.cnf" do
  action   :create
  source   "mysql/templates/mysqld_utf8.cnf.erb"
  mode     "0644"
  variables(
    charset: charset
  )
  notifies :restart, "service[mysql]"
end

service "mysql" do
  action [:enable, :restart]
end
