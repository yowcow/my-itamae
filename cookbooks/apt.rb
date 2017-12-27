execute "Copy original sources.list" do
  command <<-CMD
    cp /etc/apt/sources.list /etc/apt/sources.list.old
  CMD
  not_if "test -f /etc/apt/sources.list.old"
end

execute "Modify source country to 'jp'" do
  command <<-CMD
    cat /etc/apt/sources.list.old | sed -e 's/\\bus.archive.ubuntu.com\\b/jp.archive.ubuntu.com/g' > /etc/apt/sources.list.new
    mv /etc/apt/sources.list.new /etc/apt/sources.list
  CMD
end

include_recipe "apt/docker.rb"
include_recipe "apt/git.rb"
include_recipe "apt/mackerel.rb"
include_recipe "apt/virtualbox.rb"
include_recipe "apt/yarn.rb"

execute "Update apt" do
  command <<-CMD
    apt-get update -qq
  CMD
end
