%w{
  libevent-dev
  libncurses5-dev
}.each do |pkg|
  package pkg
end

version      = node[:tmux][:version]
version_file = "/usr/local/src/tmux-version"
src_dir      = "/usr/local/src/tmux"

archive = "tmux-#{version}.tar.gz"
url     = "https://github.com/tmux/tmux/releases/download/#{version}/#{archive}"

current_version = File.exists?(version_file) ? File.open(version_file).read.chomp : ""

if current_version != version then
  directory src_dir do
    mode "0755"
  end

  http_request "#{src_dir}/#{archive}" do
    url url
    not_if "test -f #{src_dir}/#{archive}"
  end

  execute "Unarchive #{src_dir}/#{archive}" do
    command <<-CMD
      tar zxf #{src_dir}/#{archive} -C #{src_dir}
    CMD
    not_if "test -d #{src_dir}/tmux-#{version}"
  end

  execute "Install tmux-#{version}" do
    command <<-CMD
      cd #{src_dir}/tmux-#{version} && \
      ./configure --prefix /usr/local && \
      make && make install
    CMD
  end

  file version_file do
    content version
    mode "0644"
  end
end
