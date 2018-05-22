execute "Install aws-cli snap" do
  command <<-CMD
    snap install --classic aws-cli
  CMD
  not_if "snap list | grep aws-cli"
end

file "/usr/local/bin/aws" do
  content <<-FILE
#!/bin/sh
exec snap run aws-cli.aws $@
  FILE
  mode "0755"
end
