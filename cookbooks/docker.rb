require 'etc'

["linux-image-extra-#{Etc.uname[:release]}",
 "linux-image-extra-virtual"
].each do |pkg|
  package pkg
end

%w{
  apt-transport-https
  ca-certificates
  software-properties-common
}.each do |pkg|
  package pkg
end

template "/etc/apt/sources.list.d/docker.list" do
  action :create
  source "docker/templates/apt-source.list.erb"
  mode "0644"
  variables(lsb_release: node[:ubuntu][:release])
end

http_request "/var/tmp/docker-gpg.key" do
  url "https://download.docker.com/linux/ubuntu/gpg"
  not_if "test -e /var/tmp/docker-gpg.key"
end

execute "Add GPG key" do
  command <<-CMD
    apt-key add /var/tmp/docker-gpg.key && \
    apt-get update -qq
  CMD
  not_if "apt-key list | grep 0EBFCD88"
end

package "docker-ce"
