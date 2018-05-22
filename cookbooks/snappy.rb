include_recipe "./snappy/awscli.rb"

execute "Refresh all snaps" do
  command <<-CMD
    snap refresh
  CMD
end
