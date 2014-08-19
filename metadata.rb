name             "SugarCRM-CE"
maintainer       "Christian Fischer"
maintainer_email "chef-cookbooks@computerlyrik.de"
license          "Apache 2.0"
description      "Installs/Configures SugarCRM CE"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.1.4"

supports "ubuntu"

depends "apt"
depends "build-essential"
depends "git"
depends "hostname"
depends "mysql"
depends "database"
depends "php"
depends "apache2"
depends "vim"
