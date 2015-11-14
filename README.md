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
A Linux script called provision.sh has been created to manage the environment and to test that the service is working correctly.  A help feature has been included which will appear if you provide no option or the word 'help'.

The provisioning script will build all 3 servers if they are not running, and will also detect if any of them are running and reprovision if necessary.  Thanks to Chef configuration only required changes will be pushed to the servers.

The script allows for all servers, the web node or the 2 app nodes to be built or provisioned, as well as a full environment decomission.

A URL test is made to ensure that hitting the web node will produce a result from each of the backend nodes at the end of the install and provision of all nodes, or can be run manually by supplying the word 'test' as an argument to the script.

The script should be run any time an update is pushed to git, such as a change to the backend Go script application, or any changes to the configuration.  The jscode lives in the appcode cookbook in the files directory for ease of deployment, but in a full server environment would come from a software repository such as artifactory, or url.


Other Notes:
Rather than over engineer, I have demonstrated the use of attributes in the webnode, but have hard coded in the app node ports
