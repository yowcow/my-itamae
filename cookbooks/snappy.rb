node[:snappy].each do |s|
  cmd = ['snap', 'install', s[:snap]]
  cmd << '--classic' if s[:classic]

  execute "Install snap: #{s[:snap]}" do
    command cmd.join(' ')
    not_if "snap list | grep #{s[:snap]}"
  end
end

file '/usr/local/etc/profile.d/snappy.sh' do
  content <<-CONTENT
PATH=/snap/bin:$PATH
  CONTENT
  mode "0644"
end

execute "Refresh all snaps" do
  command <<-CMD
    snap refresh
  CMD
end
