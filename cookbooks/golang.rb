template "/etc/profile.d/golangrc.sh" do
  action :create
  source "golang/templates/golangrc.erb"
  mode "0644"
  variables(version: node[:golang][:version])
end

http_request "/tmp/go#{node[:golang][:version]}.linux-amd64.tar.gz" do
  url "https://storage.googleapis.com/golang/go#{node[:golang][:version]}.linux-amd64.tar.gz"
  not_if "test -e /tmp/go#{node[:golang][:version]}.linux-amd64.tar.gz"
end

execute "Install Go" do
  command <<-CMD
    cd /tmp && \
    tar xzf go#{node[:golang][:version]}.linux-amd64.tar.gz && \
    mv go /usr/local/go-#{node[:golang][:version]}
  CMD
  not_if "test -e /usr/local/go-#{node[:golang][:version]}"
end
