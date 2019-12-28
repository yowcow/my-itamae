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

archive = "protobuf-cpp-#{version}.tar.gz"
url     = "https://github.com/google/protobuf/releases/download/v#{version}/#{archive}"
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
    not_if "test -d /tmp/protobuf-#{version}"
  end

  execute "Install to #{target}" do
    command <<-CMD
      cd /tmp/protobuf-#{version} && \
      ./configure --prefix=#{target} && \
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
