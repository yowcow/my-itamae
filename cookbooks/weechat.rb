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

version      = node[:weechat][:version]
version_file = "/usr/local/src/weechat-version"

archive = "weechat-#{version}.tar.xz"
url     = "https://weechat.org/files/src/#{archive}"

current_version = File.exists?(version_file) ? File.open(version_file).read.chomp : ""

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
      cmake ../weechat-#{version} -DENABLE_PHP=OFF && \
      make && make install
    CMD
  end

  file version_file do
    content version
    mode "0644"
  end
end
