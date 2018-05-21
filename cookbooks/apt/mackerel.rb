template "/etc/apt/sources.list.d/mackerel.list" do
  action :create
  source "templates/sources.list.d/mackerel.list.erb"
  mode   "0644"
end

execute "Add GPG key" do
  command <<-CMD
    curl -LfsS https://mackerel.io/file/cert/GPG-KEY-mackerel-v2 | apt-key add -
  CMD
end
