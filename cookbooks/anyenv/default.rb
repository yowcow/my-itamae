git node[:anyenv][:install_dir] do
  repository "https://github.com/riywo/anyenv.git"
  action :sync
end

template node[:anyenv][:shell_profile] do
  action :create
  mode   "0644"
  source "templates/etc/profile.d/anyenvrc.sh.erb"
  variables(
    install_dir: node[:anyenv][:install_dir]
  )
end
