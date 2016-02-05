#!/usr/bin/env bash

apt-get update

apt-get install openjdk-7-jre-headless -y

wget https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.7.3.deb
dpkg -i elasticsearch-1.7.3.deb

# ES 1.5, 1.7

/usr/share/elasticsearch/bin/plugin -install elasticsearch/license/latest
/usr/share/elasticsearch/bin/plugin -install elasticsearch/shield/latest

/usr/share/elasticsearch/bin/shield/esusers useradd es_admin -r admin -p qqq123

echo "192.168.33.10 vagrant-es-server" >> /etc/hosts 
echo "192.168.33.1 vagrant-es-client" >> /etc/hosts

echo "network.host: vagrant-es-server" >> /etc/elasticsearch/elasticsearch.yml

echo "shield.ssl.keystore.path: /vagrant/certs/server/server.jks" >> /etc/elasticsearch/elasticsearch.yml
echo "shield.ssl.keystore.password:      qqq123" >> /etc/elasticsearch/elasticsearch.yml
echo "shield.transport.ssl:              true" >> /etc/elasticsearch/elasticsearch.yml
echo "shield.ssl.hostname.verification.resolve.name: false" >> /etc/elasticsearch/elasticsearch.yml
echo "transport.profiles.client.shield.ssl.client.auth: no" >> /etc/elasticsearch/elasticsearch.yml
echo "cluster.name: es-syslog-ng" >> /etc/elasticsearch/elasticsearch.yml

service elasticsearch start
