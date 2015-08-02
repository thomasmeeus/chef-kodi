# encoding: utf-8
name 'chef-kodi'
description 'Installs and configures a Kodi on Debian'
maintainer 'Thomas Meeus'
maintainer_email 'thomas@sector7g.be'
license 'MIT'
version '1.0'

%w(debian).each do |os|
  supports os
end

depends 'apt'
depends 'limits'
