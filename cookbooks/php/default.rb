%w{
  php5
  php5-cli
  php5-cgi
  php5-mysql
  php5-sqlite
}.each do |pkg|
  package pkg
end
