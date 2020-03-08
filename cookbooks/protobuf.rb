%w{
  autoconf
  automake
  libtool
  unzip
}.each do |pkg|
  package pkg
end

version      = node[:protobuf][:version]
version_file = "/usr/local/src/protobuf-version"
src_dir      = "/usr/local/src/protobuf"

archive = "protobuf-cpp-#{version}.tar.gz"
url     = "https://github.com/protocolbuffers/protobuf/releases/download/v#{version}/#{archive}"

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
    not_if "test -d #{src_dir}/protobuf-#{version}"
  end

  execute "Install protobuf-#{version}" do
    command <<-CMD
      cd #{src_dir}/protobuf-#{version} && \
      ./configure --prefix=/usr/local && \
      CC=/usr/bin/clang CXX=/usr/bin/clang++ make && \
      make install
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
