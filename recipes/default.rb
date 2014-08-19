#
# Cookbook Name:: sugarcrm
# Recipe:: default
#
# Copyright 2011, SugarCRM
# Copyright 2014, computerlyrik
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
::Chef::Recipe.send(:include, Opscode::OpenSSL::Password)

include_recipe 'apt'
include_recipe 'apache2'
include_recipe 'git'
include_recipe 'application'

node.set['mysql']['server_root_password'] = secure_password if node['mysql']['server_root_password'] == 'ilikerandompasswords'

include_recipe 'mysql::server'

include_recipe 'php::module_mysql'

node.set_unless['sugarcrm']['db']['password'] = secure_password
node.set_unless['sugarcrm']['admin_pass'] = secure_password

application 'sugarcrm' do
  path node['sugarcrm']['webroot']
  owner node['apache']['user']
  group node['apache']['group']
  repository 'git://github.com/sugarcrm/sugarcrm_dev.git'
  revision node['sugarcrm']['version'] || 'master'

  mod_php_apache2 do
    server_aliases [node['fqdn'], node['host_name']]
    webapp_template 'web_app.conf.erb'
  end
  php do
    local_settings_file 'config_si.php'
  end
end

cron 'sugarcron' do
  minute '*/2'
  command "/usr/bin/php -f #{node['sugarcrm']['webroot']}/cron.php >> /dev/null"
  user node['apache']['user']
end
