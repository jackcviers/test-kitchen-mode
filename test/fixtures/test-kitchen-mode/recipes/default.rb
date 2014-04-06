include_recipe "apt::default"

apt_repository "numix/ppa" do
  uri 'http://ppa.launchpad.net/numix/ppa/ubuntu'
  distribution node['lsb']['codename']
  components ['main']
  keyserver 'keserver.ubuntu.com'
  key '43E076121739DEE5FB96BBED52B709720F164EEB'
  action :add
end
