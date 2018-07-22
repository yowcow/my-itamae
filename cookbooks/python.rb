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

execute "pip install neovim" do
  command <<-CMD
    pip install neovim
  CMD
end

execute "pip3 install neovim" do
  command <<-CMD
    pip3 install neovim
  CMD
end
