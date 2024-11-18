Vagrant.configure("2") do |config|
    # Configuration for the Client
    config.vm.define "client" do |client|
      client.vm.box = "ubuntu/focal64"
      client.vm.network "private_network", ip: "192.168.10.3", virtualbox__intnet: "net_client_isp"
      client.vm.network "public_network", ip: "192.168.133.21", bridge: "wlp4s0"
      client.vm.hostname = "client"
      client.vm.provider "virtualbox" do |vb|
        vb.memory = "2048"
        vb.cpus = 2
      end
      client.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "/home/vagrant/.ssh/authorized_keys"
      client.vm.provision "shell", inline: <<-SHELL
        chmod 700 /home/vagrant/.ssh
        chmod 600 /home/vagrant/.ssh/authorized_keys
        chown -R vagrant:vagrant /home/vagrant/.ssh
      SHELL
    end
  
    # Configuration for the ISP_Router
    config.vm.define "isp_router" do |isp_router|
      isp_router.vm.box = "ubuntu/focal64"
      isp_router.vm.network "private_network", ip: "192.168.10.4", virtualbox__intnet: "net_client_isp"
      isp_router.vm.network "private_network", ip: "192.168.20.3", virtualbox__intnet: "net_isp_edge"
      isp_router.vm.network "public_network", ip: "192.168.133.22", bridge: "wlp4s0"
      isp_router.vm.hostname = "isp-router"
      isp_router.vm.provider "virtualbox" do |vb|

        vb.memory = "2048"
        vb.cpus = 2
      end
      isp_router.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "/home/vagrant/.ssh/authorized_keys"
      isp_router.vm.provision "file", source: "setup_bird_isp/script.sh", destination: "/home/vagrant/setup_bird.sh"
      isp_router.vm.provision "shell", inline: <<-SHELL
        chmod 700 /home/vagrant/.ssh
        chmod 600 /home/vagrant/.ssh/authorized_keys
        chown -R vagrant:vagrant /home/vagrant/.ssh
        sudo apt update && sudo apt install bird -y
        sudo bash setup_bird.sh
        sudo systemctl restart bird
      SHELL
    end

    # Web_Server
    config.vm.define "web_server" do |web_server|
      web_server.vm.box = "ubuntu/focal64"
      web_server.vm.network "private_network", ip: "192.168.30.6", virtualbox__intnet: "net_edge_internal"
      web_server.vm.network "public_network", ip: "192.168.133.24", bridge: "wlp4s0"
      web_server.vm.hostname = "web-server"
      web_server.vm.provider "virtualbox" do |vb|

        vb.memory = "2048"
        vb.cpus = 2
      end
      web_server.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "/home/vagrant/.ssh/authorized_keys"
      web_server.vm.provision "file", source: "web_server/index.html", destination: "/home/vagrant/index.html"
      web_server.vm.provision "file", source: "tune_tcp/sysctl.conf", destination: "/home/vagrant/sysctl.conf"
      web_server.vm.provision "shell", inline: <<-SHELL
        chmod 700 /home/vagrant/.ssh
        chmod 600 /home/vagrant/.ssh/authorized_keys
        chown -R vagrant:vagrant /home/vagrant/.ssh
        sudo apt update && sudo apt install nginx -y
        sudo mv index.html /var/www/html/index.nginx-debian.html
        sudo nginx -s reload

        sudo mv sysctl.conf /etc/sysctl.conf
        sudo sysctl -p

      SHELL
    end

    # Edge_Server
    config.vm.define "edge_server" do |edge_server|
      edge_server.vm.box = "ubuntu/focal64"
      edge_server.vm.network "private_network", ip: "192.168.20.4", virtualbox__intnet: "net_isp_edge"
      edge_server.vm.network "private_network", ip: "192.168.30.5", virtualbox__intnet: "net_edge_internal"
      edge_server.vm.network "public_network", ip: "192.168.133.23", bridge: "wlp4s0"
      edge_server.vm.hostname = "edge-server"
      edge_server.vm.provider "virtualbox" do |vb|

        vb.memory = "2048"
        vb.cpus = 2
      end
      edge_server.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "/home/vagrant/.ssh/authorized_keys"
      edge_server.vm.provision "file", source: "setup_bird_edge/script.sh", destination: "/home/vagrant/setup_bird.sh"
      edge_server.vm.provision "file", source: "nginx_edge/nginx.conf", destination: "/home/vagrant/nginx.conf"
      edge_server.vm.provision "file", source: "nginx_edge/cdn.conf", destination: "/home/vagrant/cdn.conf"
      edge_server.vm.provision "file", source: "tune_tcp/sysctl.conf", destination: "/home/vagrant/sysctl.conf"
      edge_server.vm.provision "shell", inline: <<-SHELL
        chmod 700 /home/vagrant/.ssh
        chmod 600 /home/vagrant/.ssh/authorized_keys
        chown -R vagrant:vagrant /home/vagrant/.ssh
        sudo apt update && sudo apt install nginx bird -y
        sudo bash setup_bird.sh
        sudo systemctl restart bird

        sudo mv nginx.conf /etc/nginx/nginx.conf
        sudo mv cdn.conf /etc/nginx/conf.d/cdn.conf

        sudo nginx -s reload
        sudo mv sysctl.conf /etc/sysctl.conf
        sudo sysctl -p

      SHELL
    end

    # Logger
    config.vm.define "logger" do |logger|
      logger.vm.box = "ubuntu/focal64"
      logger.vm.network "private_network", ip: "192.168.30.7", virtualbox__intnet: "net_edge_internal"
      logger.vm.network "public_network", ip: "192.168.133.25", bridge: "wlp4s0"
      logger.vm.hostname = "logger"
      logger.vm.provider "virtualbox" do |vb|

        vb.memory = "2048"
        vb.cpus = 2
      end
      logger.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "/home/vagrant/.ssh/authorized_keys"
      logger.vm.provision "shell", inline: <<-SHELL
        chmod 700 /home/vagrant/.ssh
        chmod 600 /home/vagrant/.ssh/authorized_keys
        chown -R vagrant:vagrant /home/vagrant/.ssh
      SHELL
    end
end