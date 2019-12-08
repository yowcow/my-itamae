template "/etc/apt/sources.list.d/google-chrome.list" do
  action :create
  source "templates/sources.list.d/google-chrome.list.erb"
  mode   "0644"
end

execute "Add GPG key" do
  command <<-CMD
    curl https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
  CMD
end
