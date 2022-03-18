#!/bin/bash
<<INFO
Date: 2022 Match 17
Author: Prakhar Khandelwal
Purpose: To run vpn.sh script on user login on a new terminal
INFO

# kill all previous openvpns when you login.
sudo killall openvpn
gnome-terminal -e "vpn.sh"
