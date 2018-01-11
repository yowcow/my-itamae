package "dconf-cli"

# https://github.com/Mayccoll/Gogh
execute "install gogh" do
  command <<-CMD
    curl -L https://git.io/vQgMr -o /usr/local/bin/gogh &&
    chmod +x /usr/local/bin/gogh
  CMD
end
