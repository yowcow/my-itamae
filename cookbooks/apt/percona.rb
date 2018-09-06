deb = "percona-release_0.1-6.#{$LSB_RELEASE}_all.deb"
url = "https://repo.percona.com/apt/#{deb}"

installed = `dpkg -l | grep percona-release | awk '$1 == "ii" { print }' | wc -l | tr -d '\n'` != "0"

if not installed then
  http_request "/tmp/#{deb}" do
    url url
    not_if "test -f /tmp/#{deb}"
  end

  execute "Install #{deb}" do
    command <<-CMD
      dpkg -i /tmp/#{deb}
    CMD
  end
end
