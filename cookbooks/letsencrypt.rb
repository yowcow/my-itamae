package 'certbot'

template "/etc/cron.daily/letsencrypt" do
  action :create
  source "letsencrypt/templates/crontab/letsencrypt.erb"
  mode "0775"
end

template "/etc/logrotate.d/letsencrypt" do
  action :create
  source "letsencrypt/templates/logrotate/letsencrypt.erb"
  mode "0644"
end
