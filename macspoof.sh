#!/bin/bash

#for interface in wlan0 eth0;
#do macchanger -r $interface --bia
#done

ip link show|awk '/^[0-9]/{printf "%s\n" ,$2}'\
|sed 's/://g'>$PWD/interfaces.txt
: '
1st argument@awk..leave out anything with 0-9 characters
 and print the string in
2nd position each on a new line

2nd argument @sed ..delete colons 


'
LOGFILE="$PWD/macspoof.log"
td=`date +%T`
Interface1=lo
Interface2=vboxnet0
Interface3=ppp0
echo "$td:interfaces going down.."
while read LINE ;
do New_Interfaces="$(echo $LINE)"
#if [ $New_Interfaces!=lo ] || [ $New_Interfaces!=vboxnet0 ]
#then 
#echo $New_Interfaces

#interfaces have to be down befor e changing mac

for interface in $New_Interfaces;
do 

if [ $interface = $Interface1 -o $interface = $Interface2 -o $Interface3 ]
then
echo "Can't bring down $interface"
else
sudo -s;ifconfig $interface down
STATUS1="$?"
if [ "$STATUS1" -eq 0 ];
then echo " $td: $interface down..switching mac"
else echo " $td:error in bringing down $interface"
fi
fi
done

if [ $New_Interfaces = lo -o $New_Interfaces = vboxnet0 -o $New_Interfaces = ppp0 ]
then
echo "Can't macspoof for $New_Interfaces" 
#echo "Can't macspoof for loopback"
else
#echo $New_Interfaces nuh        
sudo macchanger -r --bia $New_Interfaces 
fi
done <  $PWD/interfaces.txt

#uncomment if you want the interfaces to be up after boot up
#for interface in wlan0 eth0 ;
#do ifconfig $interface up
#done
exit
