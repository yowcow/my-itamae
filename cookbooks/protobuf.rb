version = node[:protobuf][:version]
archive = "/var/tmp/protoc-#{version}-linux-x86_64.zip"
target  = "/usr/local/protobuf-#{version}"
profile = "/etc/profile.d/protobuf.sh"

http_request archive do
  url "https://github.com/google/protobuf/releases/download/v#{version}/protoc-#{version}-linux-x86_64.zip"
  not_if "test -f #{archive}"
end

execute "Install protobuf #{version}" do
  command <<-CMD
    unzip #{archive} -d #{target}
    find #{target} -type d -exec chmod 755 {} \\;
    find #{target} -type f -exec chmod 644 {} \\;
    chmod 755 #{target}/bin/protoc
  CMD
  not_if "test -d #{target}"
end

execute "Install profile.d" do
  command <<-CMD
    echo PATH=/usr/local/protobuf-#{version}/bin:#{'\$PATH'} > #{profile}
  CMD
  not_if "test -f #{profile}"
end
