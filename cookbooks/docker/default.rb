package "docker.io" do
  action :install
end

execute "docker group" do
  command "usermod -aG docker #{node[:common][:user]}"
end
