git node[:rakudobrew][:install_dir] do
  user node[:common][:user]
  repository "https://github.com/tadzik/rakudobrew"
  action :sync
end

template node[:rakudobrew][:profile_file] do
  user node[:common][:user]
  action :create
  mode   "0644"
  source "templates/etc/profile.d/rakudobrew.sh.erb"
  variables(
    install_dir: node[:rakudobrew][:install_dir]
  )
end

execute "Build Moar" do
  user node[:common][:user]
  command <<-CMD
    . #{node[:rakudobrew][:profile_file]};
    rakudobrew build moar #{node[:perl6][:version]}
  CMD
  not_if "test -e #{node[:rakudobrew][:install_dir]}/moar-#{node[:perl6][:version]}"
end

execute "Build Panda" do
  user node[:common][:user]
  command <<-CMD
    . #{node[:rakudobrew][:profile_file]};
    rakudobrew build-panda
  CMD
  not_if "test -e #{node[:rakudobrew][:install_dir]}/moar-#{node[:perl6][:version]}/panda"
end
