#
# Cookbook Name:: webnode
# Recipe:: default
#
# Copyright 2015, TPS Services Ltd
#
# All rights reserved - Do Not Redistribute
#

package 'nginx' do
	action :install
end

service 'nginx' do
	action [:enable, :start]
end

template 'nginx.conf' do
	path "#{node[:webnode][:dir]}/nginx.conf"
	source 'nginx.conf.erb'
	owner "#{node[:webnode][:owner]}"
	group "#{node[:webnode][:group]}"
	mode "#{node[:webnode][:mode]}"
	notifies :restart, resources(:service => 'nginx')
end

execute 'firewall' do
	command 'firewall-cmd --permanent --zone=public --add-service=http;firewall-cmd --zone=public --add-service=http'
	not_if 'firewall-cmd --list-all | grep http'
end
