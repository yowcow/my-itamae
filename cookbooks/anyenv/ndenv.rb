execute "Install NodeJS #{node[:nodejs][:version]}" do
  user "vagrant"
  command <<-CMD
    . /home/vagrant/.anyenvrc
    ndenv install #{node[:nodejs][:version]}
  CMD
  not_if "test -e /home/vagrant/.anyenv/envs/ndenv/versions/#{node[:nodejs][:version]}"
end

execute "Set NodeJS #{node[:nodejs][:version]} as default" do
  user "vagrant"
  command <<-CMD
    . /home/vagrant/.anyenvrc
    ndenv global #{node[:nodejs][:version]}
  CMD
end
