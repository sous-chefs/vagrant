name             'vagrant'
maintainer       'Joshua Timberman'
maintainer_email 'cookbooks@housepub.org'
license          'Apache 2.0'
description      'Installs/Configures vagrant'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.2.1'

supports 'debian', '>= 6.0'
supports 'ubuntu', '>= 12.04'
supports 'redhat', '>= 6.3'
supports 'windows'
supports 'mac_os_x'

depends "dmg"
depends "windows"
