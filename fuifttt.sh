#!/bin/bash
PHONENUMBER="$1"
for i in i80 us50 sr88; do
    if curl -s http://www.dot.ca.gov/hq/roadinfo/display.php?page=$i | grep -v "CLOSED TO SINGLE DRIVE"  | grep -i closed >/dev/null ;
    then echo $i closed; rm -f /tmp/$i.open;
      if [[ -f /tmp/$i.closed ]];
        then echo mail\ already\ sent;
        else touch /tmp/$i.closed;
          curl -s http://www.dot.ca.gov/hq/roadinfo/display.php?page=$i  | grep -i closed | awk -v i="$i" '{print 'i'$0}' | tr -d \\r  | mutt -s "$i" $PHONENUMBER;
      fi ;
    else echo $i opened; rm -f /tmp/$i.closed;
      if [[ -f /tmp/$i.open ]];
        then echo mail\ already\ sent;
        else touch /tmp/$i.open; echo "$i Open\!" | tr -d \\r  | mutt -s "$i" $PHONENUMBER;
      fi;
    fi;
 done
