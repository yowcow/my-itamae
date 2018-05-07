version = node[:helloworld][:version]
archive = "helloworld.#{version}.linux-amd64.tar.gz"
url = "https://github.com/yowcow/helloworld/releases/download/#{version}/#{archive}"
targetdir = "/usr/local/helloworld-#{version}"

http_request "/tmp/#{archive}" do
  url url
  not_if "test -d #{targetdir} || test -f /tmp/#{archive}"
end

execute "Extract /tmp/#{archive}" do
  command <<-CMD
    mkdir -p /tmp/helloworld-#{version}
    tar xzf /tmp/#{archive} -C /tmp/helloworld-#{version}
  CMD
  not_if "test -d #{targetdir} || test -d /tmp/helloworld-#{version}"
end

directory targetdir do
  action :create
end

directory "#{targetdir}/bin" do
  action :create
end

execute "Move helloworld to #{targetdir}/bin" do
  command <<-CMD
    cp /tmp/helloworld-#{version}/helloworld #{targetdir}/bin/helloworld
  CMD
  not_if "test -f #{targetdir}/bin/helloworld"
end

template "/etc/systemd/system/helloworld.service" do
  action :create
  source "helloworld/templates/helloworld.service.erb"
  mode "0644"
  variables(
    user: "www-data",
    group: "www-data",
    workdir: "#{targetdir}"
  )
end

execute "Register helloworld to systemd" do
  command <<-CMD
    systemctl daemon-reload && \
    systemctl enable helloworld && \
    systemctl stop helloworld && \
    systemctl start helloworld
  CMD
end
