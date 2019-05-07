include_recipe "./ctags.rb"
include_recipe "./lua.rb"
include_recipe "./python.rb"

%w{
  autoconf
  automake
  cmake
  gettext
  libtool
  libtool-bin
  pkg-config
}.each do |pkg|
  package pkg
end

version = node[:neovim][:version]

archive = "v#{version}.tar.gz"
url = "https://github.com/neovim/neovim/archive/#{archive}"
dir = "/usr/local/neovim-v#{version}"

if not File.exists?("#{dir}/bin/nvim") then
  http_request "/tmp/#{archive}" do
    url url
    not_if "test -f /tmp/#{archive}"
  end

  execute "extract #{archive}" do
    command <<-CMD
      tar xzf /tmp/#{archive} -C /tmp
    CMD
    not_if "test -d /tmp/neovim-#{version}"
  end

  template "/tmp/neovim-#{version}/Makefile.patch" do
    source "neovim/patch/Makefile.patch"
    mode "0644"
  end

  execute "patch Makefile" do
    command <<-CMD
      cd /tmp/neovim-#{version} && \
      (patch -u -s -f < Makefile.patch) || true
    CMD
  end

  execute "install neovim v#{version}" do
    command <<-CMD
      cd /tmp/neovim-#{version} && \
      make CMAKE_INSTALL_PREFIX=#{dir} CMAKE_BUILD_TYPE=Release && \
      make CMAKE_INSTALL_PREFIX=#{dir} CMAKE_BUILD_TYPE=Release install
    CMD
  end
end

link "/usr/local/bin/nvim" do
  to "#{dir}/bin/nvim"
  force true
end

#url = "https://github.com/neovim/neovim/releases/download/v#{version}/nvim.appimage"
#dir = "/usr/local/neovim-v#{version}/bin"
#
#directory dir do
#  action :create
#end
#
#http_request "#{dir}/nvim" do
#  url url
#  mode "0755"
#  not_if "test -f #{dir}/nvim"
#end
#
#link "/usr/local/bin/nvim" do
#  to "#{dir}/nvim"
#  force true
#end
