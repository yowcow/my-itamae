version = node[:perl][:version]

archive = "perl-#{version}.tar.gz"
url     = "http://www.cpan.org/src/5.0/#{archive}"

target  = "/usr/local/perl-#{version}"
profile = "/usr/local/etc/profile.d/perlrc.sh"

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

file profile do
  content <<-CONTENT
PATH=#{target}/bin:$PATH
  CONTENT
  mode "0644"
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
    cpanm Carton IO::Socket::SSL Perl::Tidy Minilla
  CMD
end
