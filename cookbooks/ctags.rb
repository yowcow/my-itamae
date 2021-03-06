version      = node[:ctags][:version]
version_file = "/usr/local/src/ctags-version"
src_dir      = "/usr/local/src/ctags"

archive = "ctags-#{version}.tar.gz"
url     = "http://prdownloads.sourceforge.net/ctags/#{archive}"

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
      tar xzf #{src_dir}/#{archive} -C #{src_dir}
    CMD
    not_if "test -d #{src_dir}/ctags-#{version}"
  end

  execute "Install ctags-#{version}" do
    command <<-CMD
      cd #{src_dir}/ctags-#{version} && \
      ./configure --prefix /usr/local && \
      make && make install
    CMD
  end

  file version_file do
    content version
    mode "0644"
  end
end
