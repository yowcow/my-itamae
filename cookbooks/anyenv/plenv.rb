execute "Install Perl #{node[:perl][:version]}" do
  command <<-CMD
    . /home/vagrant/.anyenvrc
    plenv install #{node[:perl][:version]}
  CMD
  not_if "test -e /usr/local/anyenv/envs/plenv/versions/#{node[:perl][:version]}"
end

execute "Set Perl #{node[:perl][:version]} as default" do
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
    command <<-CMD
      . /home/vagrant/.anyenvrc
      cpanm #{module_name}
    CMD
  end
end

execute "Fix file owner" do
  command <<-CMD
    chown -R vagrant:vagrant /home/vagrant/.cpanm
  CMD
end
