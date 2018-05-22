version = node[:ctags][:version]

archive = "ctags-#{version}.tar.gz"
url     = "http://prdownloads.sourceforge.net/ctags/#{archive}"

target  = "/usr/local/ctags-#{version}"
profile = "/usr/local/etc/profile.d/ctags.sh"

http_request "/tmp/#{archive}" do
  url url
  not_if "test -d #{target} || test -f /tmp/#{archive}"
end

execute "Unarchive #{archive}" do
  command <<-CMD
    tar xzf /tmp/ctags-#{version}.tar.gz -C /tmp
  CMD
  not_if "test -d #{target} || test -d /tmp/ctags-#{version}"
end

execute "Install #{target}" do
  command <<-CMD
    cd /tmp/ctags-#{version} && \
    ./configure --prefix #{target} && \
    make && make install
  CMD
  not_if "test -d #{target}"
end

file profile do
  content <<-CONTENT
PATH=#{target}/bin:$PATH
  CONTENT
  mode "0644"
end
