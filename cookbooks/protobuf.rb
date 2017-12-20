version = node[:protobuf][:version]

archive = "protoc-#{version}-linux-x86_64.zip"
url     = "https://github.com/google/protobuf/releases/download/v#{version}/#{archive}"

target  = "/usr/local/protobuf-#{version}"
profile = "/etc/profile.d/protobuf.sh"

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

execute "Install #{profile}" do
  command <<-CMD
    echo PATH=#{target}/bin:#{'\$PATH'} > #{profile}
  CMD
  not_if "test -f #{profile}"
end
