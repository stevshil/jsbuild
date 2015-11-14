#
# Cookbook Name:: appnode
# Recipe:: default
#
# Copyright 2015, TPS Services Ltd
#
# All rights reserved - Do Not Redistribute
#

package 'golang' do
	action :install
end

directory '/usr/lib/golang/src/jscode' do
	owner 'root'
	group 'root'
	mode '0755'
	action :create
end

cookbook_file '/usr/lib/golang/src/jscode/jscode.go' do
	source 'jscode.go'
	owner 'root'
	group 'root'
	mode '0644'
	action :create
end

cookbook_file '/etc/init.d/jsgo' do
	source 'jscode'
	owner 'root'
	group 'root'
	mode '755'
	action :create
end

service 'jsgo' do
	action [:enable, :start]
end

execute 'buildjsgo' do
	command 'go install jscode'
	only_if ' test /usr/lib/golang/src/jscode.go -nt /usr/lib/golang/bin/jscode'
	notifies :restart, resources(:service => 'jsgo')
end

execute 'firewall' do
        command 'firewall-cmd --permanent --zone=public --add-port=8484/tcp;firewall-cmd --zone=public --add-port=8484/tcp'
        not_if 'firewall-cmd --list-all | grep "8484/tcp"'
end

