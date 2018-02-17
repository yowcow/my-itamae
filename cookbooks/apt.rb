execute "Copy original sources.list" do
  command <<-CMD
    cp /etc/apt/sources.list /etc/apt/sources.list.old
  CMD
  not_if "test -f /etc/apt/sources.list.old"
end

#execute "Modify source country to 'jp'" do
#  command <<-CMD
#    cat /etc/apt/sources.list.old | sed -e 's/\\bus.archive.ubuntu.com\\b/jp.archive.ubuntu.com/g' > /etc/apt/sources.list.new
#    mv /etc/apt/sources.list.new /etc/apt/sources.list
#  CMD
#end

node[:apt][ENV["ENVNAME"]].each do |repo|
  include_recipe "apt/#{repo}.rb"
end

execute "Update apt" do
  command <<-CMD
    apt-get update -qq
  CMD
end
