template "/etc/apt/sources.list.d/virtualbox.list" do
  action :create
  source "templates/sources.list.d/virtualbox.list.erb"
  mode "0644"
  variables(lsb_release: $LSB_RELEASE)
end

execute "Add GPG key" do
  command <<-CMD
    curl -sS http://download.virtualbox.org/virtualbox/debian/oracle_vbox_2016.asc | apt-key add -
    curl -sS http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc | apt-key add -
  CMD
end

