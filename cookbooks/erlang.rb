version = node[:erlang][:version]

archive = "otp_src_#{version}.tar.gz"
url     = "http://erlang.org/download/otp_src_#{version}.tar.gz"

target  = "/usr/local/erlang-#{version}"
profile = "/etc/profile.d/erlangrc.sh"

http_request "/tmp/#{archive}" do
  url url
  not_if "test -d #{target} || test -f /tmp/#{archive}"
end

execute "Extract /tmp/#{archive}" do
  command <<-CMD
    tar xf /tmp/#{archive} -C /tmp
  CMD
  not_if "test -d #{target}"
end

execute "Install to #{target}" do
  command <<-CMD
    cd /tmp/otp_src_#{version} && \
    ./configure --prefix=#{target} && \
    make && make install
  CMD
  not_if "test -d #{target}"
end

execute "Install to #{profile}" do
  command <<-CMD
    echo PATH=#{target}/bin:#{'\$PATH'} > #{profile}
  CMD
end
