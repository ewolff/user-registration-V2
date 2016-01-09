#!/bin/bash

# fix locale
locale-gen de_DE.UTF-8 en_US.UTF-8

# install JDK 8 and unzip
add-apt-repository -y ppa:openjdk-r/ppa
apt-get update
apt-get autoremove -y openjdk-7-jdk openjdk-7-jre openjdk-7-jre-headless
apt-get install -y openjdk-8-jdk unzip

# install puppet modules
PUPPET_BINARY='which puppet'
MODULES_DIRECTORY='/vagrant/modules_ext'

if [ -z "${PUPPET_BINARY}" ]; then
  echo "Puppet not installed! Please install it and run script again."
  exit 1
fi

if [ ! -e ${MODULES_DIRECTORY}/jenkins ]; then
  puppet module install rtyler-jenkins --target-dir $MODULES_DIRECTORY
fi
if [ ! -e ${MODULES_DIRECTORY}/sonarqube ]; then
  puppet module install maestrodev-sonarqube --target-dir $MODULES_DIRECTORY
fi
if [ ! -e ${MODULES_DIRECTORY}/mysql ]; then
  puppet module install puppetlabs-mysql --target-dir $MODULES_DIRECTORY
fi

if [ ! -e ${MODULES_DIRECTORY}/artifactory ]; then
  cd /tmp
  wget https://github.com/moolsan/puppet-artifactory/archive/master.zip
  unzip master.zip -d $MODULES_DIRECTORY
  mv $MODULES_DIRECTORY/puppet-artifactory-master/ $MODULES_DIRECTORY/artifactory
  rm master.zip
  cd -
fi
