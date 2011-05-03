#
# Cookbook Name:: sugarcrm
# Recipe:: default
#
# Copyright 2011, SugarCRM
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


include_recipe "apache2"
include_recipe %w{php::php5 php::module_mysql}
include_recipe "git"
include_recipe "mysql::server"

directory "#{node[:sugarcrm][:webroot]}" do
  owner "#{node[:apache][:user]}"
  group "#{node[:apache][:group]}"
  recursive true
  action :create
end

git "#{node[:sugarcrm][:webroot]}" do
  repository "git://github.com/sugarcrm/sugarcrm_dev.git"
  user "#{node[:apache][:user]}"
  group "#{node[:apache][:group]}"
  reference "master"
  action :checkout
end

template "config_si.php" do
  source "config_si.php.erb"
  path "#{node[:sugarcrm][:webroot]}/config_si.php"
  owner "#{node[:apache][:user]}"
  group "#{node[:apache][:group]}"
end

cron "sugarcron" do
  minute "*/2"
  command "/usr/bin/php -f #{node[:sugarcrm][:webroot]}/cron.php >> /dev/null"
  user "#{node[:apache][:user]}"
end
