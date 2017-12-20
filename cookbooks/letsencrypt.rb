execute "Install certbot-auto" do
  command <<-CMD
    curl -L https://dl.eff.org/certbot-auto -o /usr/local/bin/certbot-auto
    chmod 775 /usr/local/bin/certbot-auto
  CMD
end

template "/etc/cron.daily/letsencrypt" do
  action :create
  source "letsencrypt/templates/crontab/letsencrypt.erb"
  mode "0775"
end
