version      = node[:elixir][:version]
version_file = "/usr/local/src/elixir-version"

prefix  = "/usr/local/elixir"
archive = "elixir-#{version}.tar.gz"
url     = "https://github.com/elixir-lang/elixir/archive/v#{version}.tar.gz"
profile = "/etc/profile.d/elixir.sh"

current_version = File.exists?(version_file) ? File.open(version_file).read.chomp : ""

if current_version != version then
  execute "Uninstall if any exists" do
    command <<-CMD
      rm -rf #{prefix}
    CMD
  end

  http_request "/tmp/#{archive}" do
    url url
    not_if "test -e /tmp/#{archive}"
  end

  execute "Extract #{archive}" do
    command <<-CMD
      cd /tmp && tar xzf #{archive} && \
      mv elixir-#{version} #{prefix}
    CMD
  end

  execute "Build #{prefix}" do
    command <<-CMD
      LANG=en_US.UTF-8 make -C #{prefix} clean test
    CMD
  end

  file version_file do
    content version
    mode "0644"
  end
end

file profile do
  content <<-END
PATH=#{prefix}/bin:$PATH
  END
  mode "0644"
end
