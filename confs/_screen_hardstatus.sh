#!/bin/bash
#written by the lovely haired bork bork
# Script to get run by hardstatus in screen.
# Prints customized single-line system stats
DISKPERCENT=95
PROCPERCENT=90

if [ $1 == "ip" ]; then
{
	for IP in `ifconfig | grep 255.255 | cut -d: -f2 | cut -d " " -f1`
    do
	    echo -n "$IP "
    done
}
fi

if [ $1 == "mem" ]; then
	echo -n "M:"`free -m | grep Mem: | awk '{print ($4 * 100/$2)}' | sed -e 's,\.[0-9]*,%,g'`
fi

if [ $1 == "disk" ]; then
	df -l | sed -e '1d' | grep -v none | awk '{if (($3 * 100/($3+$4)) > "'"$DISKPERCENT"'") print "[ " $1 " " ($3 * 100/($3+$4)) }' | sed -e 's,\.[0-9]*,% ],g'
fi

if [ $1 == "proc" ]; then
	ps aux | sort -r -k3,3 | sed -n '2p' | awk '{if ($3 >  "'"$PROCPERCENT"'") print "[ "$2" "$11" "$3"% ]"}'
fi

if [ $1 == "bandwidth" ]; then
    RX=`ifconfig eth0 | grep bytes | awk '{print $2}' | cut -d ':' -f2`
    TX=`ifconfig eth0 | grep bytes | awk '{print $6}' | cut -d ':' -f2`
    if [ -f /tmp/prevstatusRX ]  && [ -f /tmp/prevstatusTX ]; then
        prevRX=`cat /tmp/prevstatusRX`
        prevTX=`cat /tmp/prevstatusTX`
        bytediffRX=$[RX-prevRX]
        bytediffTX=$[TX-prevTX]
        timecur=`date +"%s"`
        timeRX=`stat -c %Y /tmp/prevstatusRX`
        timeTX=`stat -c %Y /tmp/prevstatusTX`
        timeRX=$[timecur-timeRX]
        timeTX=$[timecur-timeTX]
        kbpsRX=`echo "scale=1; ($bytediffRX*8/$timeRX)/1024" | bc`
        kbpsTX=`echo "scale=1; ($bytediffTX*8/$timeTX)/1024" | bc`
        echo -n "U:"$kbpsTX"kbs D:"$kbpsRX"kbs"
        echo $RX > /tmp/prevstatusRX
        echo $TX > /tmp/prevstatusTX
    else
        echo $RX > /tmp/prevstatusRX
        echo $TX > /tmp/prevstatusTX
    fi
fi
