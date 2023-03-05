#!/bin/bash
### docker
sudo yum update -y
sudo yum install -y git
sudo yum install -y docker
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -a -G docker ec2-user
sudo mkdir -p /usr/local/lib/docker/cli-plugins
sudo curl \
-L https://github.com/docker/compose/releases/download/v2.15.1/docker-compose-$(uname -s)-$(uname -m) \
-o /usr/local/lib/docker/cli-plugins/docker-compose
sudo chmod +x /usr/local/lib/docker/cli-plugins/docker-compose
sudo ln -s /usr/local/lib/docker/cli-plugins/docker-compose /usr/bin/docker-compose

### mysql
sudo yum remove -y mariadb-*
sudo yum install -y --enablerepo=mysql80-community mysql-community-server
sudo yum localinstall -y https://dev.mysql.com/get/mysql80-community-release-el7-5.noarch.rpm
sudo yum install -y --enablerepo=mysql80-community mysql-community-server
sudo yum install -y --enablerepo=mysql80-community mysql-community-devel
sudo touch /var/log/mysqld.log
sudo systemctl start mysqld 
sudo systemctl enable mysqld
