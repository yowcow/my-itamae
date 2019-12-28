version      = node[:elixir][:version]
version_file = "/usr/local/src/elixir-version"

url     = "https://github.com/elixir-lang/elixir/archive/v#{version}.tar.gz"
archive = "elixir-#{version}.tar.gz"
target  = "/usr/local/elixir"
profile = "/etc/profile.d/elixir.sh"

current_version = File.exists?(version_file) ? File.open(version_file).read.chomp : ""

if current_version != version then
  execute "Uninstall if any exists" do
    command <<-CMD
      rm -rf #{target}
    CMD
  end

  http_request "/tmp/#{archive}" do
    url url
    not_if "test -e /tmp/#{archive}"
  end

  execute "Extract #{archive}" do
    command <<-CMD
      cd /tmp && tar xzf #{archive} && \
      mv elixir-#{version} #{target}
    CMD
  end

  execute "Build #{target}" do
    command <<-CMD
      LANG=en_US.UTF-8 make -C #{target} clean compile test
    CMD
  end

  file version_file do
    content version
    mode "0644"
  end
end

file profile do
  content <<-END
PATH=/usr/local/elixir/bin:$PATH
  END
  mode "0644"
end
