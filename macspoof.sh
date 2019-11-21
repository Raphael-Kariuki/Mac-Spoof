#!/bin/bash
LOGFILE="/home/$USER/Desktop/macspoof.log"
td=`date +%T`
#interfaces have to be down befor e changing mac
echo "$td:interfaces going down.."
for interface in wlan0 eth0;
do ifconfig $interface down
STATUS1="$?"
if [ "$STATUS1" -eq 0 ];
then echo " $td: $interface down"
else echo " $td:error in bringing down $interface"
fi
done

for interface in wlan0 eth0;
do macchanger -r $interface --bia
done

#uncomment if you want the interfaces to be up after boot up
#for interface in wlan0 eth0 ;
#do ifconfig $interface up
#done
exit
