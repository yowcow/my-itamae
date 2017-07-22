http_request "/usr/local/bin/certbot-auto" do
  url "https://dl.eff.org/certbot-auto"
  mode "0775"
end

template "/etc/cron.daily/letsencrypt" do
  action :create
  source "letsencrypt/templates/crontab/letsencrypt.erb"
  model "0755"
end
