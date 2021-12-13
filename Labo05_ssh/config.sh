#!/bin/sh

sudo ifconfig ens160u1 192.168.0.1 netmask 255.255.255.0
sudo ip route add 192.168.0.11 via 192.168.0.1

ifconfig

nano /home/lmi/.ssh/known_hosts
