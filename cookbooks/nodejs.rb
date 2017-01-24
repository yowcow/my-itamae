template "/etc/profile.d/nodejsrc.sh" do
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

%w{
  forever
  forever-monitor
  npm-check-updates
  yarn
}.each do |mod|
  execute "Install #{mod}" do
    command <<-CMD
      . /etc/profile.d/nodejsrc.sh
      npm i -g #{mod}
    CMD
    not_if "test -e /usr/local/node-#{node[:nodejs][:version]}-linux-x64/lib/node_modules/#{mod}"
  end
end
