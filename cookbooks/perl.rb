directory "/usr/local/etc/profile.d" do
  action :create
end

template "/usr/local/etc/profile.d/perlrc" do
  action :create
  source "perl/templates/perlrc.erb"
  mode "0644"
  variables(version: node[:perl][:version])
end

http_request "/tmp/perl-#{node[:perl][:version]}.tar.gz" do
  url "http://www.cpan.org/src/5.0/perl-#{node[:perl][:version]}.tar.gz"
  not_if "test -e /tmp/perl-#{node[:perl][:version]}.tar.gz"
end

execute "Install Perl #{node[:perl][:version]}" do
  command <<-CMD
    cd /tmp && \
    tar xzf perl-#{node[:perl][:version]}.tar.gz && \
    cd perl-#{node[:perl][:version]} && \
    ./Configure -des -Dprefix=/usr/local/perl-#{node[:perl][:version]} && \
    make && make install
  CMD
  not_if "test -e /usr/local/perl-#{node[:perl][:version]}"
end

execute "Install cpanm" do
  command <<-CMD
    . /usr/local/etc/profile.d/perlrc
    curl -L https://cpanmin.us | /usr/local/perl-#{node[:perl][:version]}/bin/perl - App::cpanminus
  CMD
  not_if "test -e /usr/local/perl-#{node[:perl][:version]}/bin/cpanm"
end

execute "Install Carton" do
  command <<-CMD
    . /usr/local/etc/profile.d/perlrc
    cpanm Carton
  CMD
  not_if "test -e /usr/local/perl-#{node[:perl][:version]}/bin/carton"
end

execute "Install Perl::Tidy" do
  command <<-CMD
    . /usr/local/etc/profile.d/perlrc
    cpanm Perl::Tidy
  CMD
  not_if "test -e /usr/local/perl-#{node[:perl][:version]}/bin/perltidy"
end

#execute "Install ExtUtils::MakeMaker" do
#  command <<-CMD
#    /usr/local/perl-#{node[:perl][:version]}/bin/cpanm ExtUtils::MakeMaker
#  CMD
#end
