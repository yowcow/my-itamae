version = node[:erlang][:version]

archive = "OTP-#{version}.tar.gz"
dir     = "otp-OTP-#{version}"
url     = "https://github.com/erlang/otp/archive/OTP-#{version}.tar.gz"

target  = "/usr/local/erlang-#{version}"
profile = "/usr/local/etc/profile.d/erlangrc.sh"

http_request "/tmp/#{archive}" do
  url url
  not_if "test -d #{target} || test -f /tmp/#{archive}"
end

execute "Extract /tmp/#{archive} to /tmp/#{dir}" do
  command <<-CMD
    tar xzf /tmp/#{archive} -C /tmp
  CMD
  not_if "test -d #{target} || test -d /tmp/#{dir}"
end

execute "Install from /tmp/#{dir} to #{target}" do
  command <<-CMD
    cd /tmp/#{dir} && \
    ./otp_build autoconf && \
    ./configure --prefix=#{target} && \
    make && make install
  CMD
  not_if "test -d #{target}"
end

file profile do
  content <<-CONTENT
PATH=#{target}/bin:$PATH
  CONTENT
  mode "0644"
end

include_recipe "./erlang/rebar3.rb"
