$LSB_RELEASE = `lsb_release -c -s | tr -d "\n"`

template "/etc/apt/sources.list.d/docker.list" do
  action :create
  source "templates/sources.list.d/docker.list.erb"
  mode "0644"
  variables(lsb_release: $LSB_RELEASE)
end

execute "Add GPG key" do
  command <<-CMD
    curl -sS https://download.docker.com/linux/ubuntu/gpg | apt-key add -
  CMD
end

