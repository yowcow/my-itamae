include_recipe "./ctags.rb"
include_recipe "./lua.rb"
include_recipe "./python.rb"

version = node[:vim][:version]

archive = "vim-#{version}.tar.gz"
url     = "https://github.com/vim/vim/archive/v#{version}.tar.gz"
target  = "/usr/local"
version_file = "/usr/local/src/vim-version"

current_version = File.exists?(version_file) ? File.open(version_file).read.chomp : ""

if current_version != version then
  http_request "/tmp/#{archive}" do
    url url
  end

  execute "Extract #{archive}" do
    command <<-CMD
      tar xzf /tmp/#{archive} -C /tmp
    CMD
  end

  execute "Install to #{target}" do
    command <<-CMD
      cd /tmp/vim-#{version}/src \
      && ./configure \
        --prefix=#{target} \
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
