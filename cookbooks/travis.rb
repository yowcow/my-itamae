package "ruby-dev"

execute "travis" do
  command <<-CMD
    gem install travis -v #{node[:travis][:version]} --no-rdoc --no-ri
  CMD
end
