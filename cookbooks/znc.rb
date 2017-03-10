package "znc"

group "znc" do
  gid 2001
end

user "znc" do
  uid 2001
  gid 2001
  system_user true
  shell "/bin/false"
  home "/var/lib/znc"
  create_home true
end

template "/etc/systemd/system/znc.service" do
  action :create
  source "znc/templates/systemd/znc.service.erb"
  mode "0644"
  variables(
    user: "znc",
    group: "znc",
    working_directory: "/var/lib/znc"
  )
end
