#! /bin/sh
#Filter input stream with format like /etc/passwd
#and output an office directory.
umask 077
USER=/home/abel/Desktop/Bash/pd.key.user.$$
PERSON=/home/abel/Desktop/Bash/pd.key.person.$$
OFFICE=/home/abel/Desktop/Bash/pd.key.office.$$
TEL=/home/abel/Desktop/Bash/pd.key.tel.$$

cut -d: -f 1,5 $1 > $USER
sed -e 's;/.*;;' < $USER | sort > $PERSON
sed -e 's;^\([^:]*\):.*/\(.*\)/\(.*\);\1:\2;' < $USER | sort >$OFFICE
sed -e 's;^\([^:]*\):.*/\(.*\)/\(.*\);\1:\3;' < $USER | sort >$TEL

join -t: $PERSON $OFFICE | join -t: - $TEL | cut -d: -f 2- | awk -F: '{printf("%-39s\t%s\t%s\n",$1,$2,$3)}'
