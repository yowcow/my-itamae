%w{
  autoconf
  libc-ares-dev
  libtool
  pkg-config
}.each do |pkg|
  package pkg
end

version = node[:grpc][:version]

archive = "grpc-#{version}.tar.gz"
url     = "https://github.com/grpc/grpc/archive/v#{version}.tar.gz"
target  = "/usr/local"
version_file = "#{target}/src/grpc-version"

current_version = `[ -f #{version_file} ] && (cat #{version_file} | tr -d '\n')`

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
      make && make install prefix=#{target}
    CMD
  end

  execute "Save #{version_file}" do
    command <<-CMD
      echo #{version} > #{version_file}
    CMD
  end

  execute "Refresh ld.so.cache" do
    command <<-CMD
      ldconfig
    CMD
  end
end
