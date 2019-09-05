$LSB_RELEASE = `lsb_release -c -s | tr -d "\n"`

template "/etc/apt/sources.list.d/google-cloud-sdk.list" do
  action :create
  source "templates/sources.list.d/google-cloud-sdk.list.erb"
  mode   "0644"
  variables(lsb_release: $LSB_RELEASE)
end

execute "Add GPG key" do
  command <<-CMD
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
  CMD
end
