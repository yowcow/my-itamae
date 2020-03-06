%w{
  ntp
}.each do |pkg|
  package pkg
end

execute "disable timesyncd" do
  command <<-CMD
    timedatectl set-ntp no
  CMD
end

service "ntp" do
  action [:enable, :start]
end
