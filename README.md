## AUTO VPN Connector

Connecting to VPN is simply a chaotic thing whenever our network changes or switches, we have to <b>stop</b>-><b>type</b>-><b>start</b> that whole thing again and this may take up our few seconds and i am damn lazy.

This is just to reduce my(maybe yours as well) those few seconds and sit back, relax and enjoy seemless connectivity with the db :P

### So, if it sounds great to you please follow the steps below:

<br>
Download both these files into your system

# Step 1

```
sudo cp vpn.sh /usr/local/bin/
sudo cp startup-pk.sh /usr/local/bin/
```

# Step 2

There are two ways you may comfortable with:

1. When you log in, this script runs automatically.
2. Manually run the `startup.sh` when logging in.

## Run script at login (Ubuntu)

1. Press the Super key (windows key).
2. Type "Startup Applications"
3. Click on the Startup Applications option
4. Click "Add"
5. In the "name" field, type Terminal
6. In the "command" field, type gnome-terminal -e "vpn.sh"
7. Click "Add"

This will trigger `gnome-terminal` with `vpn.sh`

<!--
## Run script at login (Windows)

1. <a href="https://www.groovypost.com/howto/install-and-start-bash-in-windows-10-anniversary-update/">Enable Windows Subsystem for Linux in Windows 10</a>
2. Create a shortcut to the `vpn.sh` file.
3. Once the shortcut is created, right-click the shortcut file and select Cut.
4. Press Windows+R, then type `shell:startup`.
5. Once the Startup folder is opened, click Edit in the menu bar, then Paste to paste the shortcut file into the Startup folder. If you do not see the menu bar, press the Alt key to make the menu bar visible. Any shortcuts in the Startup folder will automatically run each time the user logs in to Windows. -->

# Step 3

<b>Create a file named client.cred and add below lines and store in <u>/etc/openvpn/</u></b>

<!-- (for Windows create whereever you like and pass the folder name down below) -->

prakhar.khandelwal@aceturtle.com<br>
_password_

<b>Within your `.ovpn` file find `auth-user-pass`</b>

`auth-user-pass /etc/openvpn/client.cred`

## Congratulations!! You are good to go.
