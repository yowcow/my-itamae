execute "Install Perl #{node[:perl][:version]}" do
  user "vagrant"
  command <<-CMD
    . /home/vagrant/.anyenvrc
    plenv install #{node[:perl][:version]}
  CMD
  not_if "test -e /home/vagrant/.anyenv/envs/plenv/versions/#{node[:perl][:version]}"
end

execute "Set Perl #{node[:perl][:version]} as default" do
  user "vagrant"
  command <<-CMD
    . /home/vagrant/.anyenvrc
    plenv global #{node[:perl][:version]}
    plenv install-cpanm
  CMD
end

%w{
  Carton
  Perl::Tidy
}.each do |module_name|
  execute "Install module: #{module_name}" do
    user "vagrant"
    command <<-CMD
      . /home/vagrant/.anyenvrc
      cpanm #{module_name}
    CMD
  end
end
