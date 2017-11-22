template "/etc/apt/sources.list.d/yarn.list" do
  action :create
  source "templates/sources.list.d/yarn.list.erb"
  mode "0644"
end

execute "Add GPG key" do
  command <<-CMD
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
  CMD
end
