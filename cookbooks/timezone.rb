timezone = "Asia/Tokyo"

execute "set timezone" do
  command <<-CMD
    ln -snf /usr/share/zoneinfo/#{timezone} /etc/localtime &&
    echo "#{timezone}" > /etc/timezone
  CMD
end
