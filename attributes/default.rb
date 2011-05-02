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


default[:sugarcrm][:db][:hostname] = 'localhost'
default[:sugarcrm][:db][:name] = 'sugarcrm'
default[:sugarcrm][:db][:user] = 'sugarcrm'
default[:sugarcrm][:dir] = 'sugarcrm'
default[:sugarcrm][:admin_pass] = 'admin'

set[:sugarcrm][:webroot] = "#{node[:apache][:docroot]}/#{node[:sugarcrm][:dir]}"

::Chef::Node.send(:include, Opscode::OpenSSL::Password)

default[:sugarcrm][:db][:password] = secure_password
