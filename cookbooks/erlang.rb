version = node[:erlang][:version]

archive = "OTP-#{version}.tar.gz"
dir     = "otp-OTP-#{version}"
url     = "https://github.com/erlang/otp/archive/OTP-#{version}.tar.gz"
version_file = "/usr/local/src/erlang-version"

current_version = File.exists?(version_file) ? File.open(version_file).read.chomp : ""

if current_version != version then
  http_request "/tmp/#{archive}" do
    url url
    not_if "test -f /tmp/#{archive}"
  end

  execute "Extract /tmp/#{archive} to /tmp/#{dir}" do
    command <<-CMD
      tar xzf /tmp/#{archive} -C /tmp
    CMD
    not_if "test -d /tmp/#{dir}"
  end

  execute "Install erlang-#{version}" do
    command <<-CMD
      cd /tmp/#{dir} && \
      ./otp_build autoconf && \
      ./configure --prefix=/usr/local && \
      make && make install
    CMD
  end

  file version_file do
    content version
    mode "0644"
  end
end

include_recipe "./erlang/rebar3.rb"
