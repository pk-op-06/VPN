#!/bin/bash
<<INFO
Date: 2022 Match 17 01:50 AM
Author: Prakhar Khandelwal
Purpose: To run vpn.sh script on user login on a new terminal
INFO

# kill all previous openvpns when you logout.
sudo killall openvpn
gnome-terminal -e "vpn.sh"
