%w{
  php5
  php5-cli
  php5-cgi
  php5-curl
  php5-mysql
  php5-sqlite
}.each do |pkg|
  package pkg
end

execute "Get composer.phar" do
  command <<-END
    cd /usr/local/bin &&
    curl -L https://getcomposer.org/installer -o composer-setup.php &&
    php composer-setup.php &&
    rm composer-setup.php &&
    ln -s composer.phar composer
  END
  not_if "test -e /usr/local/bin/composer"
end
