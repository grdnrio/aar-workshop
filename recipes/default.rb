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
directory '/var/www/AAR' do
  owner 'www-data'
  group 'www-data'
  action :create
end
