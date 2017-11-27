%w{
  logind
}.each do |d|
  directory "/etc/systemd/#{d}.conf.d" do
    action :create
    mode   "0755"
  end

  service "systemd-#{d}.service"

  template "/etc/systemd/#{d}.conf.d/#{d}.conf" do
    action :create
    source "systemd/templates/#{d}.conf"
    mode   "0644"
    notifies :restart, "service[systemd-#{d}.service]"
  end
end
