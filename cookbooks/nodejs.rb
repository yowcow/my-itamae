directory "/usr/local/etc/profile.d" do
  action :create
end

template "/usr/local/etc/profile.d/nodejsrc" do
  action :create
  source "nodejs/templates/nodejsrc.erb"
  mode "0644"
  variables(version: node[:nodejs][:version])
end

http_request "/tmp/node-#{node[:nodejs][:version]}-linux-x64.tar.xz" do
  url "https://nodejs.org/dist/#{node[:nodejs][:version]}/node-#{node[:nodejs][:version]}-linux-x64.tar.xz"
  not_if "test -e /tmp/node-#{node[:nodejs][:version]}-linux-x64.tar.xz"
end

execute "Install Nodejs #{node[:nodejs][:version]}" do
  command <<-CMD
    cd /tmp && \
    tar xf node-#{node[:nodejs][:version]}-linux-x64.tar.xz && \
    mv node-#{node[:nodejs][:version]}-linux-x64 /usr/local
  CMD
  not_if "test -e /usr/local/node-#{node[:nodejs][:version]}-linux-x64"
end

execute "Install forever" do
  command <<-CMD
    . /usr/local/etc/profile.d/nodejsrc
    npm i -g forever
  CMD
  not_if "test -e /usr/local/node-#{node[:nodejs][:version]}-linux-x64/lib/node_modules/forever"
end

execute "Install forever-monitor" do
  command <<-CMD
    . /usr/local/etc/profile.d/nodejsrc
    npm i -g forever-monitor
  CMD
  not_if "test -e /usr/local/node-#{node[:nodejs][:version]}-linux-x64/lib/node_modules/forever-monitor"
end
