package 'certbot'

template "/etc/cron.daily/certbot" do
  action :create
  source "certbot/templates/crontab/certbot.erb"
  mode "0775"
end

template "/etc/logrotate.d/certbot" do
  action :create
  source "certbot/templates/logrotate/certbot.erb"
  mode "0644"
end
