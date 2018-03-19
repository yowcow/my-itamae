version = node[:php][:composer][:version]

directory "/usr/local/php-composer-#{version}/bin" do
  action :create
end

http_request "/usr/local/php-composer-#{version}/bin/composer.phar" do
  url "https://github.com/composer/composer/releases/download/#{version}/composer.phar"
  mode "0755"
  not_if "test -e /usr/local/php-composer-#{version}/bin/composer.phar"
end

link "/usr/local/bin/composer.phar" do
  to "/usr/local/php-composer-#{version}/bin/composer.phar"
  force true
end
