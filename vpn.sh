#!/bin/bash
<<INFO
Date: 2022 Match 17
Author: Prakhar Khandelwal
Purpose: To automatically connect to vpn whenever networks changes.
INFO

################# VARIABLEs ######################
limit=10
retry=0
timer=5
################# VARIABLEs ######################

######################## FUNCTIONS START ########################

function populateIP() {
        echo $(ifconfig | grep "broadcast" | cut -d " " -f 10 | cut -d "." -f 1,2,3 | uniq)
}

<<cnLogic
Conditions to check below
"" 11 -> Retry
"" "" -> Retry
11 12 -> Network Changed & Connecting
11 11 -> Continue
11 "" -> Connecting
cnLogic
function checkNetwork() {
        # exit if retries limit exceeds.
        if [[ ${retry} -eq ${limit} ]];
        then
                echo "Reached Maximum retry limit."
                echo "Exiting..."
                exit
        fi

        if [[ ${1} == "Init" && ${2} == "" ]]
        then
                echo "Please connect to any network and come back.."
                exit
        fi

        if [[ ${2} == "" ]] # Retry Part
        then
                echo "Network Connection interrupted, killing previous all openvpn connections."
                echo "Waiting for WIFI/Ethernet to connect..."
                sudo killall openvpn
                sleep ${timer}

                retry=$((retry + 1))
                # echo "Retry attempt = "${retry}

                OCTET=${_OCTET}
                _OCTET=$(populateIP)

                checkNetwork "Reconnecting..." $_OCTET $OCTET
        
        elif [[ ${2} != ${3} ]]
        then
                retry=0
                isConnected="true"
                if [[ ${3} != "" ]]
                then
                        echo "Network Change detected."
                fi
        fi
}

# Connects to VPN
function connectToVPN() {
        _temp=$(populateIP)
        if [[ ${_temp} == "" || ${_temp} != ${_OCTET} ]]; then return; fi;
        echo "Connecting to VPN..."

        # Code starts
        echo "Killing previous all openvpn connections"
        sudo killall openvpn
        sleep 1
        sudo gnome-terminal --hide-menubar -e "openvpn --config /home/prakhar/Downloads/client.ovpn"
        sleep ${timer}
        # Code ends

        echo "Connected to VPN!"
        isConnected="false" # make sure it does not connect again till a network change
}

######################## FUNCTIONS END ########################

echo "VPN Startup"

# EXIT if no network found
OCTET=$(populateIP)
checkNetwork "Init" $OCTET ""
isConnected="true"

# Loop till manual interruption or retry limit exceeds
for(( ; ; ))
do
        if [[ ${isConnected} == "true" ]]
        then
                connectToVPN
        fi
        _OCTET=$(populateIP)
        
        checkNetwork "Loop" $_OCTET $OCTET
        
        OCTET=${_OCTET}
        sleep ${timer}
done

######################## END ########################
