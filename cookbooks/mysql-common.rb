%w{
  mysql-client
  mysql-common
}.each do |pkg|
  package pkg
end

charset = "utf8mb4"

template "/etc/mysql/conf.d/client.cnf" do
  action   :create
  source   "mysql-common/templates/client.cnf.erb"
  mode     "0644"
end
