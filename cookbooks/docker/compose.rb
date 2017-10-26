version = node[:docker][:compose][:version]

directory "/usr/local/docker-compose-#{version}/bin" do
  action :create
end

http_request "/usr/local/docker-compose-#{version}/bin/docker-compose" do
  url "https://github.com/docker/compose/releases/download/#{version}/docker-compose-Linux-x86_64"
  mode "0755"
  not_if "test -e /usr/local/docker-compose-#{version}/bin/docker-compose"
end

template "/etc/profile.d/docker-composerc.sh" do
  action :create
  source "templates/docker-composerc.erb"
  mode "0644"
  variables(version: version)
end
