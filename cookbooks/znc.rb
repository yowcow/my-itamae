package "znc"

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
