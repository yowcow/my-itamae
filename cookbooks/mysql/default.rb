%w{
  mariadb-server
  mariadb-devel
}.each do |pkg|
  package pkg do
    action :install
  end
end
