%w{
  php-cli
  php-curl
  php-dev
  php-mbstring
  php-xml
}.each do |pkg|
  package pkg
end
