zshenv = "/etc/zsh/zshenv"

execute "Copy #{zshenv} to #{zshenv}.bk" do
  command <<-CMD
    cp #{zshenv} #{zshenv}.bk
  CMD
  not_if "test -e #{zshenv}.bk"
end

template zshenv do
  source "zsh/templates/zshenv.erb"
  mode "0644"
end
