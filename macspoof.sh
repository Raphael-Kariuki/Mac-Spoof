#!/bin/bash

 
ip link show|awk '/^[0-9]/{printf "%s\n" ,$2}'\
|sed 's/://g'\
|sed 's/lo//g'\
#|sed 's/vboxnet0//g'\
|sed 's/ppp0//g'\
|sed '/^$/d'>interfaces.txt
: 'delete prepended numbers the print string at position 2
delete :
delete loopback
delete modem
delete white-space line
'
LOGFILE="$PWD/macspoof.log"
td=`date `

echo "$td:interfaces going down.."
while read LINE ;
do 

#interfaces have to be down befor e changing mac

for interface in $LINE
do 
sudo ifconfig $LINE down
STATUS1="$?"
if [ "$STATUS1" -eq 0 ];
then echo " $td: $interface down..switching mac"
else echo " $td:error in bringing down $interface"
fi
done

echo $LINE| xargs sudo macchanger -r --bia


#uncomment if you want the interfaces to be up after boot up

#sudo ifconfig $LINE up

done <  $PWD/interfaces.txt