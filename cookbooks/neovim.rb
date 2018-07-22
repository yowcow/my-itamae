version = node[:neovim][:version]
url = "https://github.com/neovim/neovim/releases/download/#{version}/nvim.appimage"
dir = "/usr/local/neovim-#{version}/bin"

directory dir do
  action :create
end

http_request "#{dir}/nvim" do
  url url
  mode "0755"
  not_if "test -f #{dir}/nvim"
end

link "/usr/local/bin/nvim" do
  to "#{dir}/nvim"
  force true
end
