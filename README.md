# jsbuild

This project builds 3 Virtual Machines as per the specification to show the understanding of DevOps capabilities.

Since this project is done off line and aimed at being available on any system I have chosen to use VirtualBox to support the 3 Linux hosts and Vagrant to provide the automation for the build and deployment of the systems.  Vagrant will act as the Chef server in this case since it allows for Chef provisioner, allowing the hosts to be built and provisioned from scratch, and to enable re-provisioning if a change is required while the hosts are live, similar to having a click button in Jenkins for a deployment to production, but instead using a command on the command line.

Requirements:
	- You will require VirtualBox and Vagrant to be installed
	- For Windows
		http://download.virtualbox.org/virtualbox/5.0.10/VirtualBox-5.0.10-104061-Win.exe
		https://releases.hashicorp.com/vagrant/1.7.4/vagrant_1.7.4.msi

	- For Linux
		- Red Hat systems
			yum -y install https://releases.hashicorp.com/vagrant/1.7.4/vagrant_1.7.4_x86_64.rpm http://download.virtualbox.org/virtualbox/5.0.10/VirtualBox-5.0-5.0.10_104061_el7-1.x86_64.rpm
		- Fedora
			yum -y install https://releases.hashicorp.com/vagrant/1.7.4/vagrant_1.7.4_x86_64.rpm http://download.virtualbox.org/virtualbox/5.0.10/VirtualBox-5.0-5.0.10_104061_fedora22-1.x86_64.rpm
		- Debian based systems
			apt-get -y install https://releases.hashicorp.com/vagrant/1.7.4/vagrant_1.7.4_x86_64.deb
		
	- For all O/S environments
		http://download.virtualbox.org/virtualbox/5.0.10/Oracle_VM_VirtualBox_Extension_Pack-5.0.10-104061.vbox-extpack

Instructions to create the environment to host the VMs;
- Install Virtualbox first onto the host that will run the environment
- Install the extension pack.  This can be done from the command line (Windows may require a reboot, or you may need to be in the Virtualbox bin directory to run the VBoxManage command);
	VBoxManage extpack install /pathToDownloaded/Oracle_VM_VirtualBox_Extension_Pack-5.0.10-104061.vbox-extpack --replace
- Install Vagrant (Windows may require a reboot to identify path settings)
- Download and extra, or git clone this project

Building and provisioning the 3 hosts
