template "/etc/apt/sources.list.d/sur5r-i3.list" do
  action :create
  source "templates/sources.list.d/sur5r-i3.list.erb"
  mode "0644"
  variables(lsb_release: node[:ubuntu][:release])
end

execute "Add keyring" do
  command <<-CMD
    /usr/lib/apt/apt-helper \
      download-file http://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2017.01.02_all.deb \
      /tmp/sur5r-keyring.deb \
      SHA256:4c3c6685b1181d83efe3a479c5ae38a2a44e23add55e16a328b8c8560bf05e5f && \
      dpkg -i /tmp/sur5r-keyring.deb
  CMD
  not_if "dpkg -S sur5r-keyring"
end
