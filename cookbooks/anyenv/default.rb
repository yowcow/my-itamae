#directory node[:anyenv][:install_dir] do
#  user node[:anyenv][:user]
#  owner node[:anyenv][:user]
#  action :create
#end

git node[:anyenv][:install_dir] do
  user node[:anyenv][:user]
  repository node[:anyenv][:repository]
  action :sync
end

#directory File::dirname(node[:anyenv][:shell_profile]) do
#  user node[:anyenv][:user]
#  owner node[:anyenv][:user]
#  action :create
#end

template node[:anyenv][:shell_profile] do
  user node[:anyenv][:user]
  action :create
  mode   "0644"
  source "templates/etc/profile.d/anyenvrc.sh.erb"
  variables(
    install_dir: node[:anyenv][:install_dir]
  )
end
