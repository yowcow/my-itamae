%w{
  ruby
  ruby-dev
}.each do |pkg|
  package pkg
end

execute "update gem" do
  command <<-CMD
    gem update --system && \
    gem update
  CMD
end

execute "gem install" do
  command <<-CMD
    gem i neovim bundler
  CMD
end
