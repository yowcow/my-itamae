%w{
  libgrpc-dev
  libprotobuf-dev
  libprotoc-dev
  protobuf-compiler
}.each do |pkg|
  package pkg
end

#version = node[:protobuf][:version]
#
#archive = "protobuf-cpp-#{version}.tar.gz"
#url     = "https://github.com/google/protobuf/releases/download/v#{version}/#{archive}"
#
#target   = "/usr/local/protobuf-#{version}"
#profile  = "/usr/local/etc/profile.d/protobuf.sh"
#ldsoconf = "/etc/ld.so.conf.d/protobuf.conf"
#
#http_request "/tmp/#{archive}" do
#  url url
#  not_if "test -d #{target} || test -f /tmp/#{archive}"
#end
#
#execute "Unarchive /tmp/#{archive}" do
#  command <<-CMD
#    cd /tmp && tar xzf #{archive}
#  CMD
#  not_if "test -d #{target} || test -d /tmp/protobuf-#{version}"
#end
#
#execute "Install to #{target}" do
#  command <<-CMD
#    cd /tmp/protobuf-#{version} && \
#    ./configure --prefix=#{target} && \
#    make && make install
#  CMD
#  not_if "test -d #{target}"
#end
#
#file profile do
#  content <<-CONTENT
#PATH=#{target}/bin:$PATH
#  CONTENT
#  mode "0644"
#end
#
#file ldsoconf do
#  content <<-CONTENT
#/usr/local/protobuf-#{version}/lib
#  CONTENT
#  mode "0644"
#end
