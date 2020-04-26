version      = node[:libressl][:version]
version_file = "/usr/local/src/libressl-version"
src_dir      = "/usr/local/src/libressl"

archive = "libressl-#{version}.tar.gz"
dir     = "libressl-#{version}"
url     = "https://ftp.openbsd.org/pub/OpenBSD/LibreSSL/#{archive}"

current_version = File.exists?(version_file) ? File.open(version_file).read.chomp : ""

if current_version != version then
  directory src_dir do
    mode "0755"
  end

  http_request "#{src_dir}/#{archive}" do
    url url
    not_if "test -f #{src_dir}/#{archive}"
  end

  execute "Extract #{src_dir}/#{archive}" do
    command <<-CMD
      tar xzf #{src_dir}/#{archive} -C #{src_dir}
    CMD
    not_if "test -d #{src_dir}/#{dir}"
  end

  execute "Install libressl-#{version}" do
    command <<-CMD
      cd #{src_dir}/#{dir} && \
      ./configure && make all install && \
      ldconfig
    CMD
  end

  file version_file do
    content version
    mode "0644"
  end
end
