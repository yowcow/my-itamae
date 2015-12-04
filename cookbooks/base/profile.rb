template "/etc/profile.d/environment.sh" do
  owner "root"
  group "root"
  action :create
  mode "0644"
  source "templates/etc/profile.d/environment.sh.erb"
end
