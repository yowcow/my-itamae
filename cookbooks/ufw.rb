env = ENV["ENVNAME"]

package 'ufw'

if not node[:ufw][env][:enable] then
  execute "disable ufw" do
    command <<-CMD
      ufw disable
    CMD
  end
else
  default = node[:ufw][env][:default]
  allow = node[:ufw][env][:allow]

  execute "ufw default to #{default}" do
    command <<-CMD
      ufw default #{default}
    CMD
  end

  allow.each do |port|
    execute "ufw to allow #{port}" do
      command <<-CMD
        ufw allow #{port}
      CMD
    end
  end

  execute "enable ufw" do
    command <<-CMD
      ufw enable
    CMD
  end
end
