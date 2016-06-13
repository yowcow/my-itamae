execute "Install plenv" do
  user node[:anyenv][:user]
  command <<-CMD
    . #{node[:anyenv][:shell_profile]}
    anyenv install plenv
  CMD
  not_if "test -e #{node[:anyenv][:install_dir]}/envs/plenv"
end

execute "Install Perl #{node[:perl][:version]}" do
  user node[:anyenv][:user]
  command <<-CMD
    . #{node[:anyenv][:shell_profile]}
    plenv install #{node[:perl][:version]}
  CMD
  not_if "test -e #{node[:anyenv][:install_dir]}/envs/plenv/versions/#{node[:perl][:version]}"
end

execute "Set Perl #{node[:perl][:version]} as default" do
  user node[:anyenv][:user]
  command <<-CMD
    . #{node[:anyenv][:shell_profile]}
    plenv global #{node[:perl][:version]}
    plenv install-cpanm
  CMD
end

%w{
  App::cpanoutdated
  Carton
  Perl::Tidy
}.each do |module_name|
  execute "Install module: #{module_name}" do
    user node[:anyenv][:user]
    command <<-CMD
      . #{node[:anyenv][:shell_profile]}
      cpanm -n #{module_name}
    CMD
  end
end
