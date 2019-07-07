#!/bin/bash

echo "What is the name of this minion server?"
read minion

echo "What is the local ip address of the master server?"
read master

sed -ri 's/^\%sudo\s+ALL=\(ALL:ALL\)+\sALL$/\%sudo\tALL=\(ALL:ALL\)\ NOPASSWD:ALL/g' /etc/sudoers

hostnamectl set-hostname video01.tube.prannon.net

if [[ ! `grep -P "127.0.1.1\s+${minion}" /etc/hosts` ]]; then  
  echo "127.0.1.1 ${minion}" | tee -a /etc/hosts
fi

apt-get -qq update
apt-get -q dist-upgrade -y

if [[ ! $(dpkg -l | egrep 'salt-master|salt-minion') ]]; then
  if [[ ! $(apt-key list | grep "SaltStack Packaging Team") ]]; then
    wget -O - https://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest/SALTSTACK-GPG-KEY.pub | sudo apt-key add -
  fi
  if [[ ! -f /etc/apt/sources.list.d/saltstack.list ]]; then
    echo "deb http://repo.saltstack.com/apt/ubuntu/16.04/amd64/archive/2018.3.3 xenial main" | tee -a /etc/apt/sources.list.d/saltstack.list
  fi
  apt-get update
  apt-get install salt-minion git -y
fi

if [[ ! $(grep "${master}" /etc/hosts) ]]; then 
  sed -ri "s/^127.0.0.1\s+localhost$/127.0.0.1\tlocalhost\n${master}\ salt/g" /etc/hosts
fi
systemctl restart salt-minion

apt autoremove -y
reboot
