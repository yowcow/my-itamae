template "/etc/apt/sources.list.d/mackerel.list" do
  action :create
  source "templates/sources.list.d/mackerel.list.erb"
  mode   "0644"
end

execute "Add GPG key" do
  command <<-CMD
    curl -LfsS https://mackerel.io/assets/files/GPG-KEY-mackerel | apt-key add -
  CMD
end
