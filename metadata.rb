name             'vagrant'
maintainer       'Joshua Timberman'
maintainer_email 'cookbooks@housepub.org'
license          'Apache 2.0'
description      'Installs/Configures vagrant'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.2.0'

supports 'debian', '>= 6.0'
supports 'ubuntu', '>= 12.04'
supports 'redhat', '>= 6.3'

depends "dmg"
depends "windows"
