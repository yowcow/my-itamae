%w{
  python
  python-dev
  python-pip
  python3
  python3-dev
  python3-pip
}.each do |pkg|
  package pkg
end

execute "pip install" do
  command <<-CMD
    pip install --upgrade msgpack pynvim neovim awscli
  CMD
end

execute "pip3 install" do
  command <<-CMD
    pip3 install --upgrade msgpack pynvim neovim awscli
  CMD
end
