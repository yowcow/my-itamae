include_recipe "./ctags.rb"
include_recipe "./lua.rb"
include_recipe "./python.rb"

version = node[:neovim][:version]

url = "https://github.com/neovim/neovim/releases/download/stable/nvim.appimage"
target = "/usr/local/bin/nvim"
version_file = "/usr/local/src/neovim-version"

current_version = File.exists?(version_file) ? File.open(version_file).read.chomp : ""

if current_version != version then
  http_request target do
    url url
    mode "0755"
  end

  file version_file do
    content version
    mode "0644"
  end
end
