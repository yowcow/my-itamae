git node[:rakudobrew][:install_dir] do
  repository "https://github.com/tadzik/rakudobrew"
  action :sync
end

template node[:rakudobrew][:profile_rc] do
  action :create
  mode   "0644"
  source "templates/etc/profile.d/rakudobrew.sh.erb"
  variables(
    install_dir: node[:rakudobrew][:install_dir]
  )
end

execute "Build Moar" do
  command <<-CMD
    . #{node[:rakudobrew][:profile_rc]};
    rakudobrew build moar
  CMD
  not_if "test -e #{node[:rakudobrew][:install_dir]}/bin/moar"
end

execute "Build Panda" do
  command <<-CMD
    . #{node[:rakudobrew][:profile_rc]};
    export PATH="#{node[:rakudobrew][:install_dir]}/moar-nom/install/share/perl6/site/bin:$PATH";
    rakudobrew build-panda
  CMD
  not_if "test -e #{node[:rakudobrew][:install_dir]}/bin/panda"
end

execute "Install Task::Star" do
  command <<-CMD
    . #{node[:rakudobrew][:profile_rc]};
    panda install Task::Star
  CMD
end
