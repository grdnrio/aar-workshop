#
# Cookbook Name:: aar-workshop
# Recipe:: default
#
# Copyright (c) 2016 Joe Gardiner, All Rights Reserved.

include_recipe 'apt::default'

package 'apache2'
package 'mysql-server'
package 'unzip'
package 'libapache2-mod-wsgi'
package 'python-pip'
package 'python-mysqldb'
