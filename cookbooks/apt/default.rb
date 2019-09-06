$LSB_RELEASE = `lsb_release -c -s | tr -d "\n"`

template "/etc/apt/sources.list" do
  action :create
  source "templates/sources.list.erb"
  mode "0644"
  variables(
    archive_mirror:  node[:apt][:mirrors][:archive],
    security_mirror: node[:apt][:mirrors][:security],
    lsb_release:     $LSB_RELEASE,
  )
end
