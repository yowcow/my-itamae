%w{
  autoconf
  libc-ares-dev
  libtool
  pkg-config
}.each do |pkg|
  package pkg
end

version      = node[:grpc][:version]
version_file = "/usr/local/src/grpc-version"

archive = "grpc-#{version}.tar.gz"
url     = "https://github.com/grpc/grpc/archive/v#{version}.tar.gz"
target  = "/usr/local"

current_version = File.exists?(version_file) ? File.open(version_file).read.chomp : ""

if current_version != version then
  http_request "/tmp/#{archive}" do
    url url
    not_if "test -f /tmp/#{archive}"
  end

  execute "Unarchive /tmp/#{archive}" do
    command <<-CMD
      cd /tmp && tar xzf #{archive}
    CMD
    not_if "test -d /tmp/grpc-#{version}"
  end

  execute "Install to #{target}" do
    command <<-CMD
      cd /tmp/grpc-#{version} && \
      CC=/usr/bin/clang CXX=/usr/bin/clang++ make && \
      make install prefix=#{target}
    CMD
  end

  file version_file do
    content version
    mode "0644"
  end

  execute "Refresh ld.so.cache" do
    command <<-CMD
      ldconfig
    CMD
  end
end
