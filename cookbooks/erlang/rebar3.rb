version = node[:erlang][:rebar3][:version]

target = "/usr/local/rebar3-#{version}/bin"

directory target do
  action :create
end

http_request "#{target}/rebar3" do
  url "https://github.com/erlang/rebar3/releases/download/#{version}/rebar3"
  mode "0755"
  not_if "test -e #{target}/rebar3"
end

link "/usr/local/bin/rebar3" do
  to "#{target}/rebar3"
  force true
end
