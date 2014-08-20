name             "sugarcrm-ce"
maintainer       "Christian Fischer"
maintainer_email "chef-cookbooks@computerlyrik.de"
license          "Apache 2.0"
description      "Installs/Configures SugarCRM CE"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.2.3"

supports 'ubuntu', '12.04'
supports 'debian'
supports 'centos'

depends 'apt'
depends 'git'
depends 'mysql'
depends 'database'
depends 'php'
depends 'apache2'
depends 'application'
depends 'application_php'
