#
# Cookbook Name:: allnodes
# Recipe:: default
#
# Copyright 2015, TPS Services Ltd
#
# All rights reserved - Do Not Redistribute
#

# Install extra repos for NGINX
execute 'rpmfusion' do
	command 'yum -y install http://download1.rpmfusion.org/free/el/updates/6/i386/rpmfusion-free-release-6-1.noarch.rpm http://download1.rpmfusion.org/nonfree/el/updates/6/i386/rpmfusion-nonfree-release-6-1.noarch.rpm'
	not_if 'rpm -qa | grep rpmfusion'
end
