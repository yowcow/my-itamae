execute "Do apt-get update" do
  now = Time.now.to_i
  timestamp = begin
    File.open('/tmp/apt-update-timestamp', 'r') { |f| f.readline.to_i }
  rescue
    0
  end

  if timestamp < now - 24 * 60 * 60
    command <<-CMD
      apt-get update;
      echo #{now} > /tmp/apt-update-timestamp;
    CMD
  end
end
