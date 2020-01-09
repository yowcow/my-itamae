version      = node[:java][:version]
version_file = "/usr/local/src/java-version"

prefix  = "/usr/local/java"
archive = "openjdk-#{version}_linux-x64_bin.tar.gz"
url     = node[:java][:url]
profile = "/etc/profile.d/java.sh"

current_version = File.exists?(version_file) ? File.open(version_file).read.chomp : ""

if current_version != version then
  execute "Remove previously installed version if exists" do
    command <<-CMD
      rm -rf #{prefix}
    CMD
  end

  http_request "/tmp/#{archive}" do
    url url
    not_if "test -f /tmp/#{archive}"
  end

  directory prefix do
    mode "0755"
  end

  execute "Install to openjdk-#{version}" do
    command <<-CMD
      tar xzf /tmp/#{archive} -C #{prefix} --strip-components 1
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
