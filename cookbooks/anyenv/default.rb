git node[:anyenv][:install_dir] do
  user node[:common][:user]
  repository "https://github.com/riywo/anyenv.git"
  action :sync
end

template node[:anyenv][:profile_file] do
  user node[:common][:user]
  action :create
  mode   "0644"
  source "templates/etc/profile.d/anyenvrc.sh.erb"
  variables(
    install_dir: node[:anyenv][:install_dir]
  )
end

execute "Initialize" do
  user node[:common][:user]
  command <<-CMD
    . #{node[:anyenv][:profile_file]};
    anyenv envs
  CMD
end
