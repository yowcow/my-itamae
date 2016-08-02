%w{
  mysql-server
  mysql-client
  libmysqlclient-dev
}.each do |pkg|
  package pkg do
    action :install
  end
end
