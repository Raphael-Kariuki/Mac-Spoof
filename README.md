#macspoof v1.0
## Author: github.com/traplab
## About
macspoof is a simple shell script that utilises the macchanger package to improve anonimity.
The goal is to change the maccaddress on interfaces automatically while booting.
##Usage
``````
git clone https://github.com/traplab/macspoof.git
cd macspoof
chmod +x install.sh
With admin rights
`````
./install.sh 

#The script will do the following
-install dependencies(macchanger, net-tools, dpkg), thus for functionality connect to the internet.
No internet and no packages, whats the use: script stops
-confirm presence of directories to copy scripts and services to directory where systemd can find em.
Negative search ,directories will be created
-change permissions of copied scripts for functionality
-enable(so as they can be started on boot up) then start service

#---\
#NB: ==>
#---/
At the moment the package works for debian installation with their basic interfaces named eth0 and wlan0
Still working on a script to detect interface names and proceed as required.


Any ideas will be highly appreciated.
