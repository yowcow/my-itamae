execute "Install ndenv" do
  user node[:anyenv][:user]
  command <<-CMD
    . #{node[:anyenv][:shell_profile]}
    anyenv install ndenv
  CMD
  not_if "test -e #{node[:anyenv][:install_dir]}/envs/ndenv"
end

execute "Install NodeJS #{node[:nodejs][:version]}" do
  user node[:anyenv][:user]
  command <<-CMD
    . #{node[:anyenv][:shell_profile]}
    ndenv install #{node[:nodejs][:version]}
  CMD
  not_if "test -e #{node[:anyenv][:install_dir]}/envs/ndenv/versions/#{node[:nodejs][:version]}"
end

execute "Set NodeJS #{node[:nodejs][:version]} as default" do
  user node[:anyenv][:user]
  command <<-CMD
    . #{node[:anyenv][:shell_profile]}
    ndenv global #{node[:nodejs][:version]}
  CMD
end
