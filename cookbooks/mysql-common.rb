%w{
  mysql-client
  mysql-common
  default-libmysqlclient-dev
}.each do |pkg|
  package pkg
end

#template "/etc/mysql/conf.d/client.cnf" do
#  action   :create
#  source   "mysql-common/templates/client.cnf.erb"
#  mode     "0644"
#end
