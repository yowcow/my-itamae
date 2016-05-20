ANYENV_GIT_USER = (ENV["CIRCLECI"] ? "ubuntu" : "root")

git node[:anyenv][:install_dir] do
  user ANYENV_GIT_USER
  repository "git@github.com:riywo/anyenv.git"
  action :sync
end

directory File::dirname(node[:anyenv][:shell_profile]) do
  action :create
end

template node[:anyenv][:shell_profile] do
  action :create
  mode   "0644"
  source "templates/etc/profile.d/anyenvrc.sh.erb"
  variables(
    install_dir: node[:anyenv][:install_dir]
  )
end
