!#/bin/bash
for i in i80 us50 sr88; do
    if curl -s http://www.dot.ca.gov/hq/roadinfo/display.php?page=$i | grep -v "CLOSED TO SINGLE DRIVE"  | grep -i closed >/dev/null ;
    then echo $i closed; rm -f /tmp/$i.open;
      if [[ -f /tmp/$i.closed ]];
        then echo mail\ already\ sent;
        else touch /tmp/$i.closed;
          curl -s http://www.dot.ca.gov/hq/roadinfo/display.php?page=$i  | grep -i closed | tr -d \\r  | mailx <phonenumber>@vtext.com;
      fi ;
    else echo $i opened; rm -f /tmp/$i.closed;
      if [[ -f /tmp/$i.open ]];
        then echo mail\ already\ sent;
        else touch /tmp/$i.open; echo "$i Open\!" | tr -d \\r  | mailx <phonenumber>@vtext.com;
      fi;
    fi;
 done
