#
# Cookbook Name:: aar-workshop
# Recipe:: firewall
#
# Copyright (c) 2016 Joe Gardiner, All Rights Reserved.

include_recipe 'firewall::default'

firewall_rule 'http' do
  port 80
  protocol :tcp
  position 1
  command :allow
end
