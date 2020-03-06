package "ntp" do
  action :remove
end

execute "enable timesyncd" do
  command <<-CMD
    timedatectl set-ntp on
  CMD
end
