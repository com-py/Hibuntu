# Hibuntu
## Installing Ubuntu on Hisense C11 ARM Chromebook

### Instructions:

The script automates installing Ubuntu on Rockchip ARM chromebooks like the Hisense C11.
It is similar to ChrUbuntu but uses Arch Linux ARM kernel and Ubuntu 14.04 LTS (trusty).
Either a microSD or USB stick can be used. I recommend the microSD option (16 or 32 GB)
because it fits flush on the Hisense C11 and can be very fast. You can have a dual-boot, full Linux
system on a nice, little and light machine like the Hisense C11.

**Requirements**: A microSD card or USB stick, wifi connection, and a Hisense C11 or alike (duh)

**1.** 	Set up developer mode and format your card/stick, following exact steps 1-8 given here:
  	
https://archlinuxarm.org/platforms/armv7/rockchip/hisense-chromebook-c11
	
By the way, if you want Arch Linux, do no more. I prefer Ubuntu. 

Next, make sure the device you want Ubuntu on is the only external device plugged in.
Power the chromebook off then on, press `Ctrl-D` at OS verification screen, do not sign in yet.

Choose either 2a or 2b. I recommend 2a because it reduces ChromeOS interference.
It is assumed you have a microSD card. For USB, replace `/dev/mmcblk1` with `/dev/sda`

**2a.**	Press `Alt-Ctrl-F2` (right arrow on top of keyboard) to login as chronos.
	At the `$` prompt, enter two commands:
```
	wget -q https://goo.gl/w1uFvM -O hibuntu
	sudo bash hibuntu /dev/mmcblk1
```
**2b.** Sign in the chromebook, download the script at https://goo.gl/w1uFvM,
	make sure to save it as **hibuntu** to the Downloads folder.
	Now, press `Alt-Ctrl-t` to get into the terminal, issue two commands:
```
	shell
	sudo bash ~/Downloads/hibuntu /dev/mmcblk1
```
It should take ~ 30 min, and done!

### Post installation:

After reboot, press `Ctrl-U` to boot from the external device. 
If it beeps, just power off and on again. Make sure your device is the only one plugged in.
```
Username:  me
Password:  root
```
To set up wireless after the first login, use these commands to scan, connect, 
and check connections; it's handy to jot these down:
```
nmcli dev wifi
sudo nmcli dev wifi con "your_net ssid" password "your_net_password" name "My wifi"
nmcli dev status
```
Wifi powersave can cause connection drops. To turn it off, issue:
```
sudo iw dev mlan0 set power_save off
```
To make it permanent, save the following as an executable `wifipoff` file in the path `/etc/pm/power.d/`
```
#!/bin/sh
/sbin/iw dev mlan0 set power_save off
```
Once you have a connection, you can add more stuff. 
For example, to add the xfce desktop and assorted programs including firefox, do:
```
sudo apt-get install openbox xubuntu-desktop
```
Finally, to check brightness, do:
```
cat /sys/devices/backlight.20/backlight/backlight.20/brightness
```
To change brightness (replace 40 by any value 0 to 100):
```
sudo chmod 666 /sys/devices/backlight.20/backlight/backlight.20/brightness
sudo echo "40" > /sys/devices/backlight.20/backlight/backlight.20/brightness
sudo chmod 644 /sys/devices/backlight.20/backlight/backlight.20/brightness
```
You can also put it in a script and bind it to a function key for easier use.
