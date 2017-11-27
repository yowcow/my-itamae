execute "Backup original NetworkManager.conf" do
  command <<-CMD
    cp /etc/NetworkManager/NetworkManager.conf /etc/NetworkManager/NetworkManager.conf.old
  CMD
  not_if "test -e /etc/NetworkManager/NetworkManager.conf.old"
end

service 'NetworkManager'

template "/etc/NetworkManager/NetworkManager.conf" do
  action :create
  source "network-manager/templates/NetworkManager.conf.erb"
  mode   "0644"
  notifies :restart, "service[NetworkManager]"
end
