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
src_dir      = "/usr/local/src/weechat"

archive = "weechat-#{version}.tar.xz"
url     = "https://weechat.org/files/src/#{archive}"

current_version = File.exists?(version_file) ? File.open(version_file).read.chomp : ""

if current_version != version then
  directory src_dir do
    mode "0755"
  end

  http_request "#{src_dir}/#{archive}" do
    url url
    not_if "test -f #{src_dir}/#{archive}"
  end

  execute "Unarchive #{src_dir}/#{archive}" do
    command <<-CMD
      tar xf #{src_dir}/#{archive} -C #{src_dir}
    CMD
    not_if "test -d #{src_dir}/weechat-#{version}"
  end

  execute "Install weechat-#{version}" do
    command <<-CMD
      rm -rf #{src_dir}/weechat-build && \
      mkdir -p #{src_dir}/weechat-build && \
      cd #{src_dir}/weechat-build && \
      cmake ../weechat-#{version} \
        -DENABLE_GUILE=OFF \
        -DENABLE_JAVASCRIPT=OFF \
        -DENABLE_PHP=OFF \
        -DENABLE_TCL=OFF \
        -DENABLE_SPELL=OFF \
      && make && make install
    CMD
  end

  file version_file do
    content version
    mode "0644"
  end
end
