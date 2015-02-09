#!/bin/sh
#
# dnsbl-check-nagios.sh
#
# (c) 2009 Damon Tajeddini & heise Netze
#
STATE_OK=0
STATE_WARNING=1
STATE_CRITICAL=2
STATE_UNKNOWN=3
STATE_DEPENDENT=4

FOUND_ADDRESS=0

DNSBLlist=`grep -v ^# <<!
cbl.abuseat.org
virbl.dnsbl.bit.nl
blackholes.five-ten-sg.com
dnsbl.inps.de
ix.dnsbl.manitu.net
no-more-funn.moensted.dk
combined.njabl.org
dnsbl.njabl.org
dnsbl.sorbs.net
bl.spamcannibal.org
bl.spamcop.net
sbl.spamhaus.org
xbl.spamhaus.org
pbl.spamhaus.org
dnsbl-1.uceprotect.net
# dnsbl-2.uceprotect.net
# dnsbl-3.uceprotect.net
psbl.surriel.com
l2.apews.org
dnsrbl.swinog.ch
db.wpbl.info
!`

# reverse IP address
convertIP()
{
 set `IFS=".";echo $1`
 echo $4.$3.$2.$1
}

usage()
{
 echo "Usage: $0 [-H] <host>] [-p]"
 echo " -H check Host "
 echo " -p print list of DNSBLs"
 exit 3
}

# Checks the IP with list of DNSBL servers
check()
{
 count=0;
 for i in $DNSBLlist
 do
 count=$(($count + 1))
 if dig $ip_arpa.$i | grep -q "ANSWER SECTION:" ;
 then
	FOUND_ADDRESS=$(($FOUND_ADDRESS + 1))
	FOUND_BLACKLISTS[$FOUND_ADDRESS]=$i
 fi
 done
 if [ $FOUND_ADDRESS -ge 1 ]
 then
	count=0
	echo "$ip is blacklisted in $FOUND_ADDRESS DNSBLs"
	for BL in "$FOUND_BLACKLISTS[@]"
	do
		count=$(($count + 1))
		echo "#${count}: $i"
	done
	exit 2
 fi
 echo "OK - $ip is not on any of $count DNSBLs"
 exit 0
}

case $1 in
 -H)
 if [ -z "$2" ]
 then
 echo "ip address missing"
 exit
 fi
 ip=$2
 ip_arpa=`convertIP $ip`
 check;;

 -p)
 for i in $DNSBLlist
 do
 echo $i
 done
 exit $STATE_WARNING
 exit;;

 --help)
 usage
 exit;;

 *)
 if [ -z "$1" ]
 then
 usage
 fi
 echo "unknown command: $1"
 exit;;
esac
