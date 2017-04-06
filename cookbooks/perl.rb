template "/etc/profile.d/perlrc.sh" do
  action :create
  source "perl/templates/perlrc.erb"
  mode "0644"
  variables(version: node[:perl][:version])
end

http_request "/var/tmp/perl-#{node[:perl][:version]}.tar.gz" do
  url "http://www.cpan.org/src/5.0/perl-#{node[:perl][:version]}.tar.gz"
  not_if "test -d /usr/local/perl-#{node[:perl][:version]}"
end

execute "Extract Perl #{node[:perl][:version]}" do
  command <<-CMD
    cd /var/tmp && \
    tar xzf perl-#{node[:perl][:version]}.tar.gz
  CMD
  not_if "test -d /usr/local/perl-#{node[:perl][:version]}"
end

execute "Install Perl #{node[:perl][:version]}" do
  command <<-CMD
    cd /var/tmp/perl-#{node[:perl][:version]} && \
    ./Configure -des -Dprefix=/usr/local/perl-#{node[:perl][:version]} && \
    make && make install
  CMD
  not_if "test -d /usr/local/perl-#{node[:perl][:version]}"
end

execute "Install cpanm" do
  command <<-CMD
    . /etc/profile.d/perlrc.sh
    curl -L https://cpanmin.us | perl - App::cpanminus
  CMD
end

execute "Install Carton" do
  command <<-CMD
    . /etc/profile.d/perlrc.sh
    cpanm Carton
  CMD
end

execute "Install Perl::Tidy" do
  command <<-CMD
    . /etc/profile.d/perlrc.sh
    cpanm Perl::Tidy
  CMD
end

execute "Install Minilla" do
  command <<-CMD
    . /etc/profile.d/perlrc.sh
    cpanm Minilla
  CMD
end
