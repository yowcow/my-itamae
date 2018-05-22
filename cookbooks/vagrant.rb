package 'vagrant'

#version = node[:vagrant][:version]
#url = "https://releases.hashicorp.com/vagrant/#{version}/vagrant_#{version}_x86_64.deb"
#deb = "vagrant_#{version}_x86_64.deb"
#
#http_request "/tmp/#{deb}" do
#  url url
#  not_if "test -f /tmp/#{deb} || (which vagrant && test $(vagrant -v | cut -d ' ' -f 2 | tr -d \"\n\") = \"#{version}\")"
#end
#
#execute "dpkg -i #{deb}" do
#  command <<-CMD
#    dpkg -i /tmp/#{deb}
#  CMD
#  not_if "which vagrant && test $(vagrant -v | cut -d ' ' -f 2 | tr -d \"\n\") = \"#{version}\""
#end
