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
src_dir      = "/usr/local/src/grpc"

archive = "grpc-#{version}.tar.gz"
url     = "https://github.com/grpc/grpc/archive/v#{version}.tar.gz"

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
    not_if "test -d #{src_dir}/grpc-#{version}"
  end

  execute "Install grpc-#{version}" do
    command <<-CMD
      cd #{src_dir}/grpc-#{version} && \
      CC=/usr/bin/clang CXX=/usr/bin/clang++ make && \
      make install prefix=/usr/local
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
