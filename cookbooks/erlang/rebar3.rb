version = node[:erlang][:rebar3][:version]

version_file = "/usr/local/src/erlang-rebar3-version"

current_version = File.exists?(version_file) ? File.open(version_file).read.chomp : ""

if current_version != version then
  http_request "/usr/local/bin/rebar3" do
    url "https://github.com/erlang/rebar3/releases/download/#{version}/rebar3"
    mode "0755"
  end

  file version_file do
    content version
    mode "0644"
  end
end
