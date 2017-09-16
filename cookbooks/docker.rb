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

execute "Add GPG key" do
  command <<-CMD
    curl -sS https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    apt-get update -qq
  CMD
end

%w{
  docker-ce
  docker-compose
}.each do |pkg|
  package pkg
end
