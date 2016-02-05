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

# download remote file and trigger extraction
remote_file "#{node['path']['site']}/master.zip" do
  source "#{node['app']['source']}"
#  owner 'www-data'
#  group 'www-data'
  mode '0755'
  action :create_if_missing
  notifies :run, 'execute[unzip_files]', :immediately
end

# extraction of master.zip notified by remote_file download
execute 'unzip_files' do
  cwd "#{node['path']['site']}"
  command "unzip master.zip"
  creates "#{node['path']['site']}/Awesome-Appliance-Repair-master"
  action :nothing
  notifies :run, 'execute[move_files]', :immediately
end

execute 'move_files' do
  cwd "#{node['path']['site']}/Awesome-Appliance-Repair-master/AAR"
  command "sudo mv * ../../."
  action :nothing
end

# tidy up master.zip file
file "#{node['path']['site']}/master.zip" do
  action :delete
end

# Create config file from template
template 'aar-apache.conf' do
  path "#{node['path']['conf']}/aar-apache.conf"
  source 'aar-apache.conf.erb'
  mode '0644'
end

# enable apache and set supported actions
service 'apache2' do
  supports :status => true, :restart => true, :reload => true, :start => true
  action [ :enable, :start ]
end
