#!/usr/bin/env bash

sudo apt-get update

sudo apt-get install expect -y
sudo apt-get install openjdk-7-jre-headless -y

wget https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.7.3.deb
sudo dpkg -i elasticsearch-1.7.3.deb

# ES 2.1
#sudo /usr/share/elasticsearch/bin/plugin -install license
#sudo /usr/share/elasticsearch/bin/plugin -install shield

# ES 1.5, 1.7

sudo /usr/share/elasticsearch/bin/plugin -install elasticsearch/license/latest
sudo /usr/share/elasticsearch/bin/plugin -install elasticsearch/shield/latest

sudo echo "192.168.33.10 vagrant-es-server" >> /etc/hosts 
sudo echo "192.168.33.1 vagrant-es-client" >> /etc/hosts

sudo echo "network.host: vagrant-es-server" >> /etc/elasticsearch/elasticsearch.yml

sudo echo "shield.ssl.keystore.path: /vagrant/certs/server/server.jks" >> /etc/elasticsearch/elasticsearch.yml
sudo echo "shield.ssl.keystore.password:      qqq123" >> /etc/elasticsearch/elasticsearch.yml
sudo echo "shield.transport.ssl:              true" >> /etc/elasticsearch/elasticsearch.yml
sudo echo "shield.ssl.hostname.verification.resolve.name: false" >> /etc/elasticsearch/elasticsearch.yml
sudo echo "transport.profiles.client.shield.ssl.client.auth: no" >> /etc/elasticsearch/elasticsearch.yml
sudo echo "cluster.name: es-syslog-ng" >> /etc/elasticsearch/elasticsearch.yml
