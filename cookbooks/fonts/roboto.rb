version = node[:font][:roboto][:version]

sourceurl  = "https://github.com/google/roboto/releases/download/#{version}/roboto-hinted.zip"
targetfile = "/usr/local/share/fonts/roboto-hinted-#{version}.zip"
targetdir  = "/usr/local/share/fonts/roboto-hinted-#{version}"

http_request targetfile do
  url sourceurl
  not_if "test -e #{targetfile}"
end

execute "Unarchive #{targetfile} to #{targetdir}" do
  command <<-CMD
    mkdir -p #{targetdir} && \
    unzip #{targetfile} -d #{targetdir};
    find #{targetdir} -type d -exec chmod 755 {} \\; && \
    find #{targetdir} -type f -exec chmod 644 {} \\;
  CMD
  not_if "test -e #{targetdir}"
end
