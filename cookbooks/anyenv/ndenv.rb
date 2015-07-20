execute "Install NodeJS #{node[:nodejs][:version]}" do
  command <<-CMD
    . /home/vagrant/.anyenvrc
    ndenv install #{node[:nodejs][:version]}
  CMD
  not_if "test -e /usr/local/anyenv/envs/ndenv/versions/#{node[:nodejs][:version]}"
end

execute "Set NodeJS #{node[:nodejs][:version]} as default" do
  command <<-CMD
    . /home/vagrant/.anyenvrc
    ndenv global #{node[:nodejs][:version]}
  CMD
end
