package "docker.io" do
  action :install
end

group "docker" do
  user node[:common][:user]
end
