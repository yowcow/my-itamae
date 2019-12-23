version = node[:php][:composer][:version]

url = "https://github.com/composer/composer/releases/download/#{version}/composer.phar"
target = "/usr/local/bin/composer.phar"
version_file = "/usr/local/src/php-composer-version"

current_version = File.exists?(version_file) ? File.open(version_file).read.chomp : ""

if current_version != version then
  http_request target do
    url url
    mode "0755"
  end

  file version_file do
    content version
    mode "0644"
  end
end
