#!/bin/bash
sudo su -
yum update
yum install -y java-1.8.0-openjdk-devel wget git
cd /opt
wget https://mirrors.estointernet.in/apache/tomcat/tomcat-8/v8.5.59/bin/apache-tomcat-8.5.59.tar.gz
tar -xvzf /opt/apache-tomcat-8.5.59.tar.gz
mv apache-tomcat-8.5.59 tomcat8
cd tomcat8/bin/

#give executing permissions to startup.sh and shutdown.sh which are under /bin
chmod +x /opt/tomcat8/bin/startup.sh
chmod +x /opt/tomcat8/bin/shutdown.sh
./startup.sh

#create link files for tomcat startup.sh and shutdown.sh
ln -s /opt/tomcat8/bin/startup.sh /usr/local/bin/tomcatup

ln -s /opt/tomcat8/bin/shutdown.sh /usr/local/bin/tomcatdown

