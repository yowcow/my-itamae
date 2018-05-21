package 'rkt'

#version = node[:rkt][:version]
#deb     = "rkt_#{version}-1_amd64.deb"
#baseurl = "https://github.com/rkt/rkt/releases/download/v#{version}"
#current = `(which rkt && rkt version) | grep "rkt Version" | cut -d " " -f 3 | tr -d "\n"`
#
#if current != version then
#  http_request "/tmp/#{deb}" do
#    url "#{baseurl}/#{deb}"
#    not_if "test -f /tmp/#{deb}"
#  end
#
#  execute "install /tmp/#{deb}" do
#    command <<-CMD
#      dpkg -i /tmp/#{deb}
#    CMD
#  end
#end
