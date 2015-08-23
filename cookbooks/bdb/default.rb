%w{
  libdb6.0-dev
  libdb6.0++-dev
}.each do |pkg|
  package pkg do
    action :install
  end
end
