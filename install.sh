#!/bin/sh

kernel="$(uname)"
arch="$(uname -m)"

PACKAGES="default-jdk"

case $kernel in
	Linux)
		echo "OS: Linux\nArch: ${arch}\n"
		sudo apt update && sudo apt upgrade -y
		sudo apt install $PACKAGES -y
		mkdir ~/Cassandra
		pip install cassandra-driver
		if [ "${arch}" = "armv7l" ]; then
			
			echo "Downloading Cassandra tarball"
			curl -OL https://dlcdn.apache.org/cassandra/4.0.3/apache-cassandra-4.0.3-bin.tar.gz
			tar xzvf apache-cassandra-4.0.3-bin.tar.gz
			
			mv apache-cassandra-4.0.3 ~/Cassandra
			cd ~/Cassandra/apache-cassandra-4.0.3/ && bin/cassandra
		else
			echo "Arch not currently targeted"
			echo "Exiting..."
			exit 1
		fi
		;;
		
esac
