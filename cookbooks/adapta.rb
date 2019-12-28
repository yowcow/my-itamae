# adapta is a GNOME GTK theme

%w{
  autoconf
  automake
  inkscape
  libgdk-pixbuf2.0-dev
  libglib2.0-dev
  libxml2-utils
  pkg-config
  sassc
}.each do |pkg|
  package pkg
end

version      = node[:adapta][:version]
version_file = "/usr/local/src/adapta-version"

url     = "https://github.com/adapta-project/adapta-gtk-theme/archive/#{version}.tar.gz"
archive = "adapta-#{version}.tar.gz"
srcdir  = "/tmp/adapta-gtk-theme-#{version}"

current_version = File.exists?(version_file) ? File.open(version_file).read.chomp : ""

if current_version != version then
  http_request "/tmp/#{archive}" do
    url url
    mode "0755"
    not_if "test -f /tmp/#{archive}"
  end

  execute "extract /tmp/#{archive}" do
    command <<-CMD
      cd /tmp && tar xzf #{archive}
    CMD
    not_if "test -d #{srcdir}"
  end

  execute "install #{srcdir} to /usr/local" do
    command <<-CMD
      cd #{srcdir} && \
      ./autogen.sh && \
      make && make install
    CMD
  end

  file version_file do
    content version
    mode "0644"
  end
end
