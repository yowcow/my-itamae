%w{
  libgrpc-dev
  libprotobuf-dev
  libprotoc-dev
  protobuf-compiler
}.each do |pkg|
  package pkg
end

version = node[:protobuf][:version]

archive = "protoc-#{version}-linux-x86_64.zip"
url     = "https://github.com/google/protobuf/releases/download/v#{version}/#{archive}"

target  = "/usr/local/protobuf-#{version}"
profile = "/usr/local/etc/profile.d/protobuf.sh"

http_request "/tmp/#{archive}" do
  url url
  not_if "test -d #{target} || test -f /tmp/#{archive}"
end

execute "Install #{target}" do
  command <<-CMD
    unzip /tmp/#{archive} -d #{target}
    find #{target} -type d -exec chmod 755 {} \\;
    find #{target} -type f -exec chmod 644 {} \\;
    chmod 755 #{target}/bin/protoc
  CMD
  not_if "test -d #{target}"
end

file profile do
  content <<-CONTENT
PATH=#{target}/bin:$PATH
  CONTENT
  mode "0644"
end
