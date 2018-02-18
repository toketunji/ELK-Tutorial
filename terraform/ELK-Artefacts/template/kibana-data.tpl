#!/bin/bash
set -e


### setup ELK REPO
### install JDK-8 and update JRE link
sudo yum -y install java-1.8.0-openjdk-devel.x86_64
sudo rm -f /usr/bin/java
sudo ln -s /usr/lib/jvm/java-1.8.0-openjdk-1.8.0.161-0.b14.36.amzn1.x86_64/bin/java  /usr/bin/java


### Install and configure Elasticsearch 
cat <<EOF >/tmp/elk.repo
[elasticsearch-6.x]
baseurl=https://artifacts.elastic.co/packages/6.x/yum
gpgcheck=0
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1 
EOF

sudo mv /tmp/elk.repo /etc/yum.repos.d/

sudo echo "root             hard    nproc           4096" >> /etc/security/limits.conf
sudo echo "root             soft    nproc           4096" >> /etc/security/limits.conf


###  install Kibana ############

sudo yum install kibana -y  && sudo service kibana start



