template "/etc/apt/sources.list.d/mackerel.list" do
  action :create
  source "mackerel/templates/apt-source.list.erb"
  mode "0644"
end

http_request "/tmp/mackerel-gpg.key" do
  url "https://mackerel.io/assets/files/GPG-KEY-mackerel"
  not_if "test -e /tmp/mackerel-gpg.key"
end

execute "Add GPG key" do
  command <<-CMD
    apt-key add /tmp/mackerel-gpg.key && \
    apt-get update -qq
  CMD
  not_if "apt-key list | grep mackerel"
end

%w{
  mackerel-agent
  mackerel-agent-plugins
}.each do |pkg|
  package pkg
end

template "/etc/mackerel-agent/mackerel-agent.conf.mine" do
  action :create
  source "mackerel/templates/mackerel-agent.conf.erb"
  mode "0644"
  variables(
    apikey: `cat /etc/mackerel-apikey.conf`.sub(/\n/, ''),
    mysql_username: `cat /etc/mysql/debian.cnf | grep user | awk '{ print $3 }' | uniq`.sub(/\n/, ''),
    mysql_password: `cat /etc/mysql/debian.cnf | grep password | awk '{ print $3 }' | uniq`.sub(/\n/, '')
  )
end

service "mackerel-agent" do
  action [:enable]
end
