version      = node[:perl][:version]
version_file = "/usr/local/src/perl-version"
src_dir      = "/usr/local/src/perl"

archive = "perl-#{version}.tar.gz"
url     = "http://www.cpan.org/src/5.0/#{archive}"

current_version = File.exists?(version_file) ? File.open(version_file).read.chomp : ""

if current_version != version then
  directory src_dir do
    mode "0755"
  end

  http_request "#{src_dir}/#{archive}" do
    url url
    not_if "test -f #{src_dir}/#{archive}"
  end

  execute "Unarchive #{src_dir}/#{archive}" do
    command <<-CMD
      tar xzf #{src_dir}/#{archive} -C #{src_dir}
    CMD
    not_if "test -d #{src_dir}/perl-#{version}"
  end

  execute "Install perl-#{version}" do
    command <<-CMD
      cd #{src_dir}/perl-#{version} && \
      ./Configure -des -Accflags=-fPIC -Dprefix=/usr/local && \
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

#execute "Install mandatory modules" do
#  command <<-CMD
#    cpanm Carton IO::Socket::SSL Perl::Tidy Minilla
#  CMD
#end
