template "/etc/apt/sources.list.d/yarn.list" do
  action :create
  source "yarn/templates/apt-source.list.erb"
  mode "0644"
end

http_request "/var/tmp/yarn-gpg.key" do
  url "https://dl.yarnpkg.com/debian/pubkey.gpg"
  not_if "test -e /var/tmp/yarn-gpg.key"
end

execute "Add GPG key" do
  command <<-CMD
    apt-key add /var/tmp/yarn-gpg.key && \
    apt-get update -qq
  CMD
  not_if "apt-key list | grep yarn"
end

package "yarn"
