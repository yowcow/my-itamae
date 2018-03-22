version = node[:terraform][:version]

archive = "terraform_#{version}_linux_amd64.zip"
url     = "https://releases.hashicorp.com/terraform/#{version}/#{archive}"

target  = "/usr/local/terraform-#{version}"
profile = "/usr/local/etc/profile.d/terraform.sh"

directory target do
  action :create
end

http_request "/tmp/#{archive}" do
  url url
  not_if "test -d #{target}/bin || test -e /tmp/#{archive}"
end

execute "unarchive /tmp/#{archive} to #{target}" do
  command <<-CMD
    unzip /tmp/#{archive} -d #{target}/bin
  CMD
  not_if "test -d #{target}/bin"
end

execute "Install #{profile}" do
  command <<-CMD
    echo PATH=#{target}/bin:#{'\$PATH'} > #{profile}
  CMD
end
