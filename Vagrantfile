# -*- mode: ruby -*-
# vi:set ft=ruby sw=2 ts=2 sts=2:

# Define the number of master and worker nodes
# If this number is changed, remember to update setup-hosts.sh script with the new hosts IP details in /etc/hosts of each VM.
JENKINS_NODE = 1
K8S_NODE = 1
NEXUS_NODE = 1
SONAR_NODE = 1
NODE1_NODE = 1


IP_NW = "192.168.56."
IP = 110
NODE_IP_START = 200

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"
  config.vm.box_check_update = false
#  config.ssh.username = "ubuntu"
#  config.ssh.private_key_path = "/home/yogesh/.ssh/id_rsa"

  # Provision jenkins server
  (1..JENKINS_NODE).each do |i|
      config.vm.define "jenkins" do |jenkins|
        # Name shown in the GUI
        jenkins.vm.provider "virtualbox" do |vb|
            vb.name = "jenkins"
            vb.memory = 2048
            vb.cpus = 2
        end
        jenkins.vm.hostname = "jenkins"
        jenkins.vm.network :private_network, ip: IP_NW + "#{IP + i}"
        jenkins.vm.network "forwarded_port", guest: 22, host: "#{2760 + i}"

#        jenkins.vm.provision "copy_public_key", type: "file", source: "ubuntu/key.pub", destination: "/home/ubuntu/.ssh/authorized_keys"
        jenkins.vm.provision "file", source: "ubuntu/key.pub", destination: "/tmp/key.pub"
        jenkins.vm.provision "file", source: "ubuntu/hosts", destination: "/etc/hosts"
        jenkins.vm.provision  "update_public_key", type: "shell", inline: "cat /tmp/key.pub > /home/ubuntu/.ssh/authorized_keys"
        jenkins.vm.provision "ansible", playbook: "ansible_config/jenkins/jenkins.yaml", inventory_path: "ansible_config/inventory.ini"

      end
  end
  # Provision k8s server
  (1..K8S_NODE).each do |i|
      config.vm.define "k8s-master" do |k8s|
        # Name shown in the GUI
        k8s.vm.provider "virtualbox" do |vb|
            vb.name = "k8s-master"
            vb.memory = 2048
            vb.cpus = 2
        end
        k8s.vm.hostname = "k8s-master"
        k8s.vm.network :private_network, ip: IP_NW + "#{IP + 2}"
        k8s.vm.network "forwarded_port", guest: 22, host: "#{2720 + i}"

#        jenkins.vm.provision "copy_public_key", type: "file", source: "ubuntu/key.pub", destination: "/home/ubuntu/.ssh/authorized_keys"
        k8s.vm.provision "file", source: "ubuntu/key.pub", destination: "/tmp/key.pub"
        k8s.vm.provision "update_public_key", type: "shell", inline: "cat /tmp/key.pub > /home/ubuntu/.ssh/authorized_keys"
        k8s.vm.provision "ansible", playbook: "ansible_config/K8S-Cluster/setup-master.yaml", inventory_path: "ansible_config/inventory.ini"

      end
  end
  
    # Provision nexus server
    (1..NEXUS_NODE).each do |i|
      config.vm.define "nexus" do |nexus|
        # Name shown in the GUI
        nexus.vm.provider "virtualbox" do |vb|
            vb.name = "nexus"
            vb.memory = 4096
            vb.cpus = 2
        end
        nexus.vm.hostname = "nexus"
        nexus.vm.network :private_network, ip: IP_NW + "#{IP + 3}"
        nexus.vm.network "forwarded_port", guest: 22, host: "#{2730 + i}"

#        jenkins.vm.provision "copy_public_key", type: "file", source: "ubuntu/key.pub", destination: "/home/ubuntu/.ssh/authorized_keys"
        nexus.vm.provision "file", source: "ubuntu/key.pub", destination: "/tmp/key.pub"
        nexus.vm.provision  "update_public_key", type: "shell", inline: "cat /tmp/key.pub > /home/ubuntu/.ssh/authorized_keys"
        nexus.vm.provision "ansible", playbook: "ansible_config/nexus/nexus.yaml", inventory_path: "ansible_config/inventory.ini"

      end
  end
  
   #Provision sonar server
    (1..SONAR_NODE).each do |i|
      config.vm.define "sonar" do |sonar|
        # Name shown in the GUI
        sonar.vm.provider "virtualbox" do |vb|
            vb.name = "sonar"
            vb.memory = 2048
        end
        sonar.vm.hostname = "sonar"
        sonar.vm.network :private_network, ip: IP_NW + "#{IP + 4}"
        sonar.vm.network "forwarded_port", guest: 22, host: "#{2740 + i}"

#        jenkins.vm.provision "copy_public_key", type: "file", source: "ubuntu/key.pub", destination: "/home/ubuntu/.ssh/authorized_keys"
        sonar.vm.provision "file", source: "ubuntu/key.pub", destination: "/tmp/key.pub"
        sonar.vm.provision  "update_public_key", type: "shell", inline: "cat /tmp/key.pub > /home/ubuntu/.ssh/authorized_keys"
        sonar.vm.provision "ansible", playbook: "ansible_config/sonar/sonar.yaml", inventory_path: "ansible_config/inventory.ini"

      end
  end
  
  # Provision node1 server
    (1..NODE1_NODE).each do |i|
      config.vm.define "node1" do |node1|
        # Name shown in the GUI
        node1.vm.provider "virtualbox" do |vb|
            vb.name = "node1"
            vb.memory = 2048
            vb.cpus = 2
        end
        node1.vm.hostname = "node1"
        node1.vm.network :private_network, ip: IP_NW + "#{IP + 5}"
        node1.vm.network "forwarded_port", guest: 22, host: "#{2750 + i}"

#        jenkins.vm.provision "copy_public_key", type: "file", source: "ubuntu/key.pub", destination: "/home/ubuntu/.ssh/authorized_keys"
        node1.vm.provision "file", source: "ubuntu/key.pub", destination: "/tmp/key.pub"
        node1.vm.provision  "update_public_key", type: "shell", inline: "cat /tmp/key.pub > /home/ubuntu/.ssh/authorized_keys"
        node1.vm.provision "file", source: "ubuntu/hosts", destination: "/tmp/hosts"
        node1.vm.provision  "update_host_file", type: "shell", inline: "cat /tmp/hosts > /etc/hosts"
        node1.vm.provision "ansible", playbook: "ansible_config/K8S-Cluster/setup-worker.yaml", inventory_path: "ansible_config/inventory.ini"

      end
  end
end

  