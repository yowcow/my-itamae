package 'docker.io'

#link "/etc/systemd/system/docker.service" do
#  to "/lib/systemd/system/docker.service"
#  force true
#end

service "docker" do
  action [:enable, :reload]
end
