#
# libgcryptXX-dev may be changed in the future ubuntu.
# See `apt-cache showpkg libgcrypt-dev` for details.
#
%w{
  ca-certificates
  gnutls-bin
  libcurl4-gnutls-dev
  libgcrypt20-dev
  libgnutls28-dev
  libncursesw5-dev
  zlib1g-dev
}.each do |pkg|
  package pkg
end

version = node[:weechat][:version]
archive = "weechat-#{version}.tar.xz"
url     = "https://weechat.org/files/src/#{archive}"
current_version = `(which weechat && weechat --version) | tail -n1 | tr -d "\n"`

if current_version != version then
  http_request "/tmp/#{archive}" do
    url url
    not_if "test -f /tmp/#{archive}"
  end

  execute "extract #{archive}" do
    command <<-CMD
      tar xf /tmp/#{archive} -C /tmp
    CMD
    not_if "test -d /tmp/weechat-#{version}"
  end

  execute "build and install weechat-#{version}" do
    command <<-CMD
      mkdir -p /tmp/weechat-build && \
      cd /tmp/weechat-build && \
      sh -c '. /etc/environment && cmake ../weechat-#{version} && make && make install'
    CMD
  end
end
