default_file = '/etc/default/sysstat'

package 'sysstat'

execute "Copy #{default_file} to #{default_file}.bk" do
  command <<-CMD
    cp #{default_file} #{default_file}.bk
  CMD
  not_if "test -e #{default_file}.bk"
end

template default_file do
  source "sysstat/templates/sysstat.erb"
  mode "0644"
end
