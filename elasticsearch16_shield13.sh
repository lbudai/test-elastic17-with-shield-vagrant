#!/usr/bin/env bash

expect -c '
set force_conservative 0  ;# set to 1 to force conservative mode even if

if {$force_conservative} {
	set send_slow {1 .1}
	proc send {ignore arg} {
		sleep .1
		exp_send -s -- $arg
	}
}

set timeout -1

spawn /usr/share/elasticsearch/bin/shield/esusers useradd es_admin -r admin
match_max 100000
expect -exact "Enter new password: "
send -- "qqq123\r"
expect -exact "\r
Retype new password: "
send -- "qqq123\r"
expect eof
'

sudo service elasticsearch start

# DEBUG
# sudo /usr/bin/java -Xms256m -Xmx1g -Djava.awt.headless=true -XX:+UseParNewGC -XX:+UseConcMarkSweepGC -XX:CMSInitiatingOccupancyFraction=75 -XX:+UseCMSInitiatingOccupancyOnly -XX:+HeapDumpOnOutOfMemoryError -XX:+DisableExplicitGC -Dfile.encoding=UTF-8 -Delasticsearch -Des.foreground=yes -Des.path.home=/usr/share/elasticsearch -cp :/usr/share/elasticsearch/lib/elasticsearch-1.7.3.jar:/usr/share/elasticsearch/lib/*:/usr/share/elasticsearch/lib/sigar/* -Des.pidfile=/var/run/elasticsearch/elasticsearch.pid -Des.default.path.home=/usr/share/elasticsearch -Des.default.path.logs=/var/log/elasticsearch -Des.default.path.data=/var/lib/elasticsearch -Des.default.config=/etc/elasticsearch/elasticsearch.yml -Des.default.path.conf=/etc/elasticsearch org.elasticsearch.bootstrap.Elasticsearch -Djava.protocol.handler.pkgs=com.sun.net.ssl.internal.www.protocol -Djavax.net.debug=ssl | nc 192.168.33.1 12333
