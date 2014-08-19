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

include_recipe 'apt'
include_recipe 'apache2'
include_recipe 'git'
#include_recipe %w(php php::module_mysql)
include_recipe 'application'
#include_recipe 'application_php'

include_recipe 'SugarCRM-CE::mysql'



application 'sugarcrm' do

  path node['sugarcrm']['webroot']
  owner "#{node[:apache]['user']}"
  group "#{node[:apache]['group']}"
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

template 'config_si.php' do
  source 'config_si.php.erb'
  path "#{node['sugarcrm']['webroot']}/config_si.php"
  notifies :restart, 'service[apache2]', :immediately
end

cron 'sugarcron' do
  minute '*/2'
  command "/usr/bin/php -f #{node['sugarcrm']['webroot']}/cron.php >> /dev/null"
  user "#{node[:apache]['user']}"
end


#  server_name
#  


# file "#{node[:apache][:docroot_dir]}/index.html" do
#  content "<body><head><meta http-equiv=\"refresh\" #content=\"0; url=/#{node['sugarcrm'][:dir]}\" /></#head></body>"
# end
