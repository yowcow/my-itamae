version      = node[:perl][:version]
version_file = "/usr/local/src/perl-version"

archive = "perl-#{version}.tar.gz"
url     = "http://www.cpan.org/src/5.0/#{archive}"
target  = "/usr/local"

current_version = File.exists?(version_file) ? File.open(version_file).read.chomp : ""

if current_version != version then
  http_request "/tmp/#{archive}" do
    url url
  end

  execute "Extract #{archive}" do
    command <<-CMD
      tar xzf /tmp/#{archive} -C /tmp
    CMD
  end

  execute "Install to #{target}" do
    command <<-CMD
      cd /tmp/perl-#{version} && \
      ./Configure -des -Accflags=-fPIC -Dprefix=#{target} && \
      make && make install
    CMD
  end

  file version_file do
    content version
    mode "0644"
  end
end

execute "Install cpanm" do
  command <<-CMD
    curl -L https://cpanmin.us | perl - App::cpanminus
  CMD
end

execute "Install mandatory modules" do
  command <<-CMD
    cpanm Carton IO::Socket::SSL Perl::Tidy Minilla
  CMD
end
