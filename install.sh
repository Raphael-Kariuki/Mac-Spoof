#!/bin/bash
#--------------------------------------
#confirming script is being run as root
#----------------------------------------
#if user aint root
if [ "$EUID" -ne 0 ];
then echo "This script must run as root.Please switch to root or use "sudo" "
exit #exit when script not run as root, otherwise continues
else read -p "We good ma nigga, welcome to macchanger.Press [ENTER] to continue with installation"

fi

#----------------------
#confirming username
#----------------------
ts=`date +%T`

echo -e "Please input your username.If running script as root enter root.Am just making your life harder coz I can"
read  user_name
if [ "$USER" != "$user_name" ];
then echo "This is as far as you can go $user_name"  
#echo " $USER"
#echo " $user_name"
exit
else
echo
fi

#----------------------
#check for dependencies
#----------------------
echo "$ts: checking for dependencies........"
#commands that will be run 
#net-tools
#apt
#macchanger
#dpkg
#------------------------------------------------------------------------------------------------------------
#script will search for packages required using dpkg -s ;if present we move forward,else install the package|
#if you are running as sudo then sudo ..... will be implemented else as root,the normal installation style|
#---------------------------------------------------------------------------------------------------------
for package in macchanger net-tools apt dpkg ;
do dpkg -s "$package" > /dev/null 2>&1 &&  echo "$package is installed"  ||
if ping -c 2 -q -W 3 google.com > /dev/null 2>&1 ;
then
echo "Downloading packages" && if [ "$EUID" -ne 0 ] ;
then sudo apt-get install $package
else
apt-get install $package
fi
exit
else
echo "My guy, hauna net.This is as far as  we can go"
fi
done


#-------------------------------------
#check for directories to copy scripts
#-----------------------------------
echo "$ts:confirming presence of necessary directories..."
if [ -d "/usr/local/bin/" -o -d "/etc/systemd/system/" ];then echo "$ts:copying scripts..." 
else for directory in "/usr/local/bin/" "/etc/systemd/system/" ;
do mkdir -p "$directory"
done 
fi
#------------------------
#copy scripts
#----------------------
cp macspoof.sh /usr/local/bin
cp macspoof.service /etc/systemd/system/

#-----------------------
#addind executable perms
#-----------------------
chmod +0644 /etc/systemd/system/macspoof.service
chmod +0755 /usr/local/bin/macspoof.sh

#------------------------------------------------
#startin and enabling the service to run at boot
#------------------------------------------------

systemctl enable macspoof.service
#I think enabling it first is wiser coz then start argument 
#will now work
systemctl start macspoof.service

