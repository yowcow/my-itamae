version      = node[:vim][:version]
version_file = "/usr/local/src/vim-version"
src_dir      = "/usr/local/src/vim"

archive = "vim-#{version}.tar.gz"
url     = "https://github.com/vim/vim/archive/v#{version}.tar.gz"

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
    not_if "test -d #{src_dir}/vim-#{version}"
  end

  execute "Install vim-#{version}" do
    command <<-CMD
      cd #{src_dir}/vim-#{version}/src \
      && ./configure \
        --prefix=/usr/local \
        --enable-fail-if-missing \
        --enable-luainterp \
        --with-lua-prefix=/usr/local \
        --enable-multibyte \
        --enable-pythoninterp=dynamic \
        --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu \
        --enable-python3interp=dynamic \
        --with-python3-config-dir=/usr/lib/python3.6/config-3.6m-x86_64-linux-gnu \
        --enable-terminal \
      && make && make install
    CMD
  end

  file version_file do
    content version
    mode "0644"
  end
end
