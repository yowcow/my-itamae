version = node[:perl][:version]

archive = "perl-#{version}.tar.gz"
url     = "http://www.cpan.org/src/5.0/#{archive}"

target  = "/usr/local/perl-#{version}"
profile = "/etc/profile.d/perlrc.sh"

http_request "/tmp/#{archive}" do
  url url
  not_if "test -d #{target} || test -f /tmp/#{archive}"
end

execute "Extract #{archive}" do
  command <<-CMD
    tar xzf /tmp/#{archive} -C /tmp
  CMD
  not_if "test -d #{target}"
end

execute "Install to #{target}" do
  command <<-CMD
    cd /tmp/perl-#{version} && \
    ./Configure -des -Dprefix=#{target} && \
    make && make install
  CMD
  not_if "test -d #{target}"
end

execute "Install #{profile}" do
  command <<-CMD
    echo PATH=#{target}/bin:#{'\$PATH'} > #{profile}
  CMD
end

execute "Install cpanm" do
  command <<-CMD
    . #{profile}
    curl -L https://cpanmin.us | perl - App::cpanminus
  CMD
end

execute "Install Carton, Perl::Tidy, Minilla" do
  command <<-CMD
    . #{profile}
    cpanm Carton Perl::Tidy Minilla
  CMD
end
