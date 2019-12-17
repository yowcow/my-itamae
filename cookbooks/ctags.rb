version = node[:ctags][:version]

archive      = "ctags-#{version}.tar.gz"
url          = "http://prdownloads.sourceforge.net/ctags/#{archive}"
version_file = "/usr/local/src/ctags-version"

current_version = File.exists?(version_file) ? File.open(version_file).read.chomp : ""

if current_version != version then
  http_request "/tmp/#{archive}" do
    url url
    not_if "test -f /tmp/#{archive}"
  end

  execute "Unarchive #{archive}" do
    command <<-CMD
      tar xzf /tmp/ctags-#{version}.tar.gz -C /tmp
    CMD
    not_if "test -d /tmp/ctags-#{version}"
  end

  execute "Install ctags" do
    command <<-CMD
      cd /tmp/ctags-#{version} && \
      ./configure --prefix /usr/local && \
      make && make install
    CMD
  end

  file version_file do
    content version
    mode "0644"
  end
end
