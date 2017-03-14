http_request "/usr/local/bin/certbot-auto" do
  url "https://dl.eff.org/certbot-auto"
  mode "0775"
end
