%w{
  ssh
  python-software-properties
  software-properties-common
  udisks
  upower
  xorg 
  alsa-utils 
  mesa-utils
  git-core
  librtmp1 
  lirc
  libmad0
  lm-sensors
  libmpeg2-4
  avahi-daemon
  libnfs4
  consolekit
  pm-utils
  vdpauinfo
  mesa-vdpau-drivers
}.each do |pkg|
  package pkg do
    action :install
  end
end


template '/etc/X11/Xwrapper.config' do
  source 'Xwrapper.config.erb'
  owner 'root'
  mode '0644'
end

template '/etc/polkit-1/localauthority/50-local.d/custom-actions.pkla' do
  source 'custom-actions.pkla.erb'
  owner 'root'
end

template '/etc/init.d/kodi' do
  source 'kodi.conf.erb'
  owner 'root'
  mode '0755'
end

user 'kodi' do
  action :create
  shell '/bin/bash'
  supports :manage_home => true
  home '/home/kodi'
end


%w{
  cdrom
  audio
  video
  plugdev
  users
  dialout
  dip
}.each do |group|
  group group do
    action :modify
    members 'kodi'
    append true
  end
end

set_limit 'kodie' do
  type '-'
  item 'nice'
  value -1
end

apt_repository 'kodi' do
  uri 'ppa:team-xbmc/ppa'
  distribution node['lsb']['codename']
end