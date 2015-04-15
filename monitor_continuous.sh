#!/bin/bash

while [ 1 ]; do
 
## Read statistics 

   f_statistic=`sudo ipvsadm -l -c`

   str_name="\t"
   str_syn_x="SYN_RECV"
   str_est_x="ESTABLISHED"
   str_tim_x="TIME_WAIT"
   str_syn_h="SYN_RECV"
   str_est_h="ESTABLISHED"
   str_tim_h="TIME_WAIT"

   for i in "37qqt1j" "4b3tr2j" "737np2j" "739j92j" "bx4x32j" "cf8ft2j" "cw6752j" "dv8x32j" "dy0752j" "fv8x32j" "fw6752j" "h93tr2j" "hkwZj2j" "hw1br1j" "j5v9d2j"
   do
       st_machine=`echo "$f_statistic" | grep tst-$i.sk`
       
       st_xmpp=`echo "$st_machine" | grep xmpp-client`
       syn_recv=`echo "$st_xmpp" | grep SYN_RECV -c`
       str_syn_x="$str_syn_x\t$syn_recv"
       established=`echo "$st_xmpp" | grep ESTABLISHED -c`
       str_est_x="$str_est_x\t$established"
       time_wait=`echo "$st_xmpp" | grep TIME_WAIT -c`
       str_tim_x="$str_tim_x\t$time_wait"
       
       st_https=`echo "$st_machine" | grep https`
       syn_recv=`echo "$st_https" | grep SYN_RECV -c`
       str_syn_h="$str_syn_h\t$syn_recv"
       established=`echo "$st_htpps" | grep ESTABLISHED -c`
       str_est_h="$str_est_h\t$established"
       time_wait=`echo "$st_htpps" | grep TIME_WAIT -c`
       str_tim_h="$str_tim_h\t$time_wait"
 
       str_name="$str_name\t$i"
   done


## Print statistics 
   
   clear
   tput cup 0 0
   echo --- ipvsadm ---
   sudo ipvsadm 
   echo ' '

   echo --- Test machine example host ---
   echo -e $str_name

   echo ' -- xmpp --'
   echo -e $str_syn_x
   echo -e $str_est_x
   echo -e $str_tim_x

   echo ' -- https --'
   echo -e $str_syn_h
   echo -e $str_est_h
   echo -e $str_tim_h

done
