package "sysstat" do
  action :install
end

service "sysstat" do
  action [:enable, :start]
end

template "/etc/default/sysstat" do
  source "templates/etc/default/sysstat.erb"
end

service "sysstat" do
  action [:enable, :reload]
end
