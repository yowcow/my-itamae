version = node[:migerl][:version]

url = "https://github.com/yowcow/migerl/releases/download/#{version}/migerl"
target = "/usr/local/bin/migerl"

current = `(which migerl 1>/dev/null && migerl -v || true) | cut -d" " -f2 | tr -d "\n"`

if current != version then
  http_request target do
    url url
    mode "0755"
  end
end
