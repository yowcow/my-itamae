%w{
  autoconf
  libc-ares-dev
  libtool
  libunwind-dev
  pkg-config
}.each do |pkg|
  package pkg
end

version      = node[:grpc][:version]
version_file = "/usr/local/src/grpc-version"
src_dir      = "/usr/local/src/grpc"

current_version = File.exists?(version_file) ? File.open(version_file).read.chomp : ""

if current_version != version then
  directory src_dir do
    mode "0755"
  end

  git "#{src_dir}/grpc-#{version}" do
    repository "https://github.com/grpc/grpc"
    not_if "test -d #{src_dir}/grpc-#{version}"
  end

  execute "Prepare #{src_dir}/grpc-#{version}" do
    command <<-CMD
      cd #{src_dir}/grpc-#{version} && \
      git checkout #{version} && \
      git submodule update --init
    CMD
  end

  execute "cmake #{src_dir}/grpc-#{version}" do
    command <<-CMD
      . /etc/profile.d/golang.sh && \
      cd #{src_dir}/grpc-#{version} && \
      rm -rf cmake/build && \
      mkdir -p cmake/build && \
      cd cmake/build && \
      cmake -DCMAKE_INSTALL_PREFIX=/usr/local ../..
    CMD
  end

  execute "make install #{src_dir}/grpc-#{version}" do
    command <<-CMD
      cd #{src_dir}/grpc-#{version}/cmake/build && \
      make && \
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
