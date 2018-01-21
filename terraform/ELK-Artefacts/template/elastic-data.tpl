#!/bin/bash
set -e


### setup ELK REPO
### install JDK-8 and update JRE link
sudo yum -y install java-1.8.0-openjdk-devel.x86_64
sudo rm -f /usr/bin/java
sudo ln -s /usr/lib/jvm/java-1.8.0-openjdk-1.8.0.151-1.b12.35.amzn1.x86_64/bin/java  /usr/bin/java


### Install and configure Elasticsearch 
cat <<EOF >/tmp/elk.repo
[elasticsearch-6.x]
baseurl=https://artifacts.elastic.co/packages/6.x/yum
gpgcheck=0
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1 
EOF

sudo mv /tmp/elk.repo /etc/yum.repos.d/
sudo yum -y  install elasticsearch

BIND=`ifconfig eth0 | grep "inet addr" | awk '{ print substr($2,6) }'`

cat <<EOF >/tmp/elasticsearch.yml
### $$BIND
path.data: /var/lib/elasticsearch
path.logs: /var/log/elasticsearch
network.host: $$BIND
#network.host: localhost
EOF

sudo mv -f /tmp/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml


cat <<EOF >/tmp/jvm.options

-Xms512m
-Xmx512m

-XX:+UseConcMarkSweepGC
-XX:CMSInitiatingOccupancyFraction=75
-XX:+UseCMSInitiatingOccupancyOnly


-XX:+AlwaysPreTouch

## basic

# force the server VM
-server

# explicitly set the stack size
-Xss1m

# set to headless, just in case
-Djava.awt.headless=true

# ensure UTF-8 encoding by default (e.g. filenames)
-Dfile.encoding=UTF-8

# use our provided JNA always versus the system one
-Djna.nosys=true

# turn off a JDK optimization that throws away stack traces for common
# exceptions because stack traces are important for debugging
-XX:-OmitStackTraceInFastThrow

# flags to configure Netty
-Dio.netty.noUnsafe=true
-Dio.netty.noKeySetOptimization=true
-Dio.netty.recycler.maxCapacityPerThread=0

# log4j 2
-Dlog4j.shutdownHookEnabled=false
-Dlog4j2.disable.jmx=true

## heap dumps

# generate a heap dump when an allocation from the Java heap fails
# heap dumps are created in the working directory of the JVM
-XX:+HeapDumpOnOutOfMemoryError

# specify an alternative path for heap dumps
# ensure the directory exists and has sufficient space
-XX:HeapDumpPath=/var/lib/elasticsearch


## binf to IPV4
java.net.preferIPv4Stack=true
EOF

sudo cp /etc/elasticsearch/jvm.options /etc/elasticsearch/jvm.option_bk
sudo mv -f /tmp/jvm.options  /etc/elasticsearch/jvm.options
sudo chkconfig --add elasticsearch
sudo echo "root             hard    nproc           4096" >> /etc/security/limits.conf
sudo echo "root             soft    nproc           4096" >> /etc/security/limits.conf

sudo service elasticsearch start >> /tmp/start.log






