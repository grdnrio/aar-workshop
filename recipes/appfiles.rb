#
# Cookbook Name:: aar-workshop
# Recipe:: appfiles
#
# Copyright (c) 2016 Joe Gardiner, All Rights Reserved.

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
