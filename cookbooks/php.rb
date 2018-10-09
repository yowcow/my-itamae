%w{
  php-cli
  php-curl
  php-mbstring
  php-xml
}.each do |pkg|
  package pkg
end
