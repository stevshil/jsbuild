Vagrant.configure(2) do | config |
  config.vm.define :default_fail do |failconfig|
    # This is here to fail the config if all machines are started by mistake
    failconfig.vm.provision :shell, :path => 'FAIL: This box is invalid, use vagrant up BOXTYPE'
  end

  # Load balancer NGINX host
  config.vm.define :lb do | lb |
    config.vm.provider "virtualbox" do |vb|
      vb.memory = 1024
      vb.name = "WebNode"
    end
    lb.vm.network "private_network", ip: "192.168.100.10", virtualbox__intnet: "NatNetwork"
    lb.vm.host_name = "webnode"
    lb.vm.network "forwarded_port", guest: 80, host: 1080, protocol: 'tcp'
    config.vm.provision "chef_solo" do | chef |
      chef.roles_path = "roles"
      chef.add_role("web_node")
      chef.node_name = "webnode"
    end
  end

  # App Node 1
  config.vm.define :ap1 do | ap1 |
    config.vm.provider "virtualbox" do |vb|
      vb.memory = 1024
      vb.name = "AppNode1"
    end
    ap1.vm.network "private_network", ip: "192.168.100.20", virtualbox__intnet: "NatNetwork"
    ap1.vm.host_name = "appnode1"
    config.vm.provision "chef_solo" do | chef |
      chef.roles_path = "roles"
      chef.add_role("appnode")
      chef.node_name = "appnode1"
    end
  end

  # App Node 2
  config.vm.define :ap2 do | ap2 |
    config.vm.provider "virtualbox" do |vb|
      vb.memory = 1024
      vb.name = "AppNode2"
    end
    ap2.vm.network "private_network", ip: "192.168.100.30", virtualbox__intnet: "NatNetwork"
    ap2.vm.host_name = "appnode1"
    config.vm.provision "chef_solo" do | chef |
      chef.roles_path = "roles"
      chef.add_role("appnode")
      chef.node_name = "appnode2"
    end
  end

  # Defaults
  config.vm.box     = "CentOS7.0_x86_64_minimal.box"
  config.vm.box_url = "https://dl.dropboxusercontent.com/u/5682093/vagrant/CentOS7-base.box"
  config.ssh.username = "vagrant"
  config.ssh.password = "vagrant"
end
