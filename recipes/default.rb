#
# Cookbook Name:: aar-workshop
# Recipe:: default
#
# Copyright (c) 2016 Joe Gardiner, All Rights Reserved.

include_recipe 'apt::default'

# install required packages
package 'apache2'
package 'mysql-server'
package 'unzip'
package 'libapache2-mod-wsgi'
package 'python-pip'
package 'python-mysqldb'
package 'vim'

# pip install required Python package
execute 'pip_flask' do
  command 'pip install flask'
end

# create website directory and set permissions
directory "#{node['path']['site']}" do
  owner 'www-data'
  group 'www-data'
  recursive true
  action :create
end

include_recipe 'aar-workshop::appfiles'

# Create AAR config file from template in web directory
template 'AAR_config.py' do
  path "#{node['path']['site']}/AAR_config.py"
  source 'AAR_config.py.erb'
  owner 'www-data'
  group 'www-data'
  mode '0644'
end

# Create config file from template
template 'aar-apache.conf' do
  path "#{node['path']['conf']}/aar-apache.conf"
  source 'aar-apache.conf.erb'
  mode '0644'
end

include_recipe 'aar-workshop::firewall'

# enable apache and set supported actions
service 'apache2' do
  supports :status => true, :restart => true, :reload => true, :start => true
  action [ :enable, :start ]
end
