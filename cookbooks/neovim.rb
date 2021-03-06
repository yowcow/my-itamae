version      = node[:neovim][:version]
version_file = "/usr/local/src/neovim-version"

url    = "https://github.com/neovim/neovim/releases/download/stable/nvim.appimage"
target = "/usr/local/bin/nvim"

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
