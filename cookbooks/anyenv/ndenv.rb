execute "Install ndenv" do
  user node[:common][:user]
  command <<-CMD
    . #{node[:anyenv][:profile_file]}
    anyenv install ndenv
  CMD
  not_if "test -e #{node[:anyenv][:install_dir]}/envs/ndenv"
end

execute "Install NodeJS #{node[:nodejs][:version]}" do
  user node[:common][:user]
  command <<-CMD
    . #{node[:anyenv][:profile_file]}
    ndenv install #{node[:nodejs][:version]}
  CMD
  not_if "test -e #{node[:anyenv][:install_dir]}/envs/ndenv/versions/#{node[:nodejs][:version]}"
end

execute "Set NodeJS #{node[:nodejs][:version]} as default" do
  user node[:common][:user]
  command <<-CMD
    . #{node[:anyenv][:profile_file]}
    ndenv global #{node[:nodejs][:version]}
  CMD
end
