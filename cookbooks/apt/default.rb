$LSB_RELEASE = `lsb_release -c -s | tr -d "\n"`

template "/etc/apt/sources.list" do
  action :create
  source "templates/sources.list.erb"
  mode "0644"
  variables(lsb_release: $LSB_RELEASE)
end
