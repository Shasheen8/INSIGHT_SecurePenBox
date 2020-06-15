#!/bin/bash

TARGET="$1"
USER_FILE="common_usernames.txt"
PASS_FILE="/usr/share/wordlists/metasploit/burnett_top_1024.txt"
MIN_PASS="common_pass.txt"
DIRB_DIR="/usr/share/dirb/wordlists/common.txt"
SNMP_STRINGS="/usr/share/seclists/Miscellaneous/wordlist-common-snmp-community-strings.txt"
OKBLUE='\033[94m'
OKRED='\033[91m'
OKGREEN='\033[92m'
OKORANGE='\033[93m'
RESET='\e[0m'

echo -e "$OKRED Scan with PenBox Enumeration Tool.$RESET"

echo -e "$OKORANGE Use ./Penbox_enum.sh target-ip-address or url ...$RESET"

nmap -sS -T5 -sV -A --open -p- $TARGET -oX $TARGET.xml
port_21=`grep 'portid="21"' $TARGET.xml | grep open`
port_22=`grep 'portid="22"' $TARGET.xml | grep open`
port_25=`grep 'portid="25"' $TARGET.xml | grep open`
port_80=`grep 'portid="80"' $TARGET.xml | grep open`
port_110=`grep 'portid="110"' $TARGET.xml | grep open`
port_111=`grep 'portid="111"' $TARGET.xml | grep open`
port_135=`grep 'portid="135"' $TARGET.xml | grep open`
port_139=`grep 'portid="139"' $TARGET.xml | grep open`
port_161=`grep 'portid="161"' $TARGET.xml | grep open`
port_162=`grep 'portid="162"' $TARGET.xml | grep open`
port_443=`grep 'portid="443"' $TARGET.xml | grep open`
port_445=`grep 'portid="445"' $TARGET.xml | grep open`
port_2121=`grep 'portid="2121"' $TARGET.xml | grep open`
port_3306=`grep 'portid="3306"' $TARGET.xml | grep open`
port_3389=`grep 'portid="3389"' $TARGET.xml | grep open`
port_8080=`grep 'portid="8080"' $TARGET.xml | grep open`
port_3000=`grep 'portid="3000"' $TARGET.xml | grep open`
port_5000=`grep 'portid="5000"' $TARGET.xml | grep open`
port_8000=`grep 'portid="8000"' $TARGET.xml | grep open`


if [ -z "$port_80" ];
	then
		echo -e "$OKRED + -- --=[Port 80 closed... skipping.$RESET"
	else
		echo -e "$OKBLUE + -- --=[Port 80 opened... running tests...$RESET"
		nikto -host $TARGET | tee nikto_assessment.txt
		davtest -url http://$TARGET/ | tee davtestresults.txt
		wpscan --url http://$TARGET/ --enumerate p | tee wpscan.txt
		nmap -p80 --script=http-adobe-coldfusion-apsa1301 --script=http-affiliate-id --script=http-apache-negotiation --script=http-apache-server-status --script=http-aspnet-debug --script=http-auth-finder --script=http-auth --script=http-backup-finder --script=http-brute --script=http-coldfusion-subzero  --script=http-config-backup --script=http-default-accounts --script=http-frontpage-login --script=http-iis-short-name-brute --script=http-iis-webdav-vuln --script=http-methods --script=http-method-tamper --script=http-passwd --script=http-phpmyadmin-dir-traversal --script=http-php-version --script=http-put --script=http-robots.txt --script=http-server-header --script=http-shellshock --script=http-title --script=http-userdir-enum --script=http-vuln-cve2006-3392 --script=http-vuln-cve2009-3960 --script=http-vuln-cve2010-0738 --script=http-vuln-cve2010-2861 --script=http-vuln-cve2011-3192 --script=http-vuln-cve2011-3368 --script=http-vuln-cve2012-1823 --script=http-vuln-cve2013-0156 --script=http-vuln-cve2013-6786 --script=http-vuln-cve2013-7091 --script=http-vuln-cve2014-2126 --script=http-vuln-cve2014-2127 --script=http-vuln-cve2014-2128 --script=http-vuln-cve2014-2129 --script=http-vuln-cve2014-3704 --script=http-vuln-cve2014-8877 --script=http-vuln-cve2015-1427 --script=http-vuln-cve2015-1635 $TARGET | tee nmapresults.txt
	fi


if [ -z "$port_443" ];
	then
		echo -e "$OKRED + -- --=[Port 443 closed... skipping.$RESET"
	else
		echo -e "$OKBLUE + -- --=[Port 443 opened... running tests...$RESET"
		nmap -p443 --script=http-adobe-coldfusion-apsa1301 --script=http-affiliate-id --script=http-apache-negotiation --script=http-apache-server-status --script=http-aspnet-debug --script=http-auth-finder --script=http-auth --script=http-backup-finder --script=http-brute --script=http-coldfusion-subzero  --script=http-config-backup --script=http-default-accounts --script=http-frontpage-login --script=http-iis-short-name-brute --script=http-iis-webdav-vuln --script=http-methods --script=http-method-tamper --script=http-passwd --script=http-phpmyadmin-dir-traversal --script=http-php-version --script=http-put --script=http-robots.txt --script=http-server-header --script=http-shellshock --script=http-title --script=http-userdir-enum --script=http-vuln-cve2006-3392 --script=http-vuln-cve2009-3960 --script=http-vuln-cve2010-0738 --script=http-vuln-cve2010-2861 --script=http-vuln-cve2011-3192 --script=http-vuln-cve2011-3368 --script=http-vuln-cve2012-1823 --script=http-vuln-cve2013-0156 --script=http-vuln-cve2013-6786 --script=http-vuln-cve2013-7091 --script=http-vuln-cve2014-2126 --script=http-vuln-cve2014-2127 --script=http-vuln-cve2014-2128 --script=http-vuln-cve2014-2129 --script=http-vuln-cve2014-3704 --script=http-vuln-cve2014-8877 --script=http-vuln-cve2015-1427 --script=http-vuln-cve2015-1635 $TARGET
		nikto -host $TARGET:443 | tee nikto_assessment.txt
		davtest -url https://$TARGET/ | tee davtestresults.txt
		wpscan --url http://$TARGET/ --enumerate p | tee wpscan.txt
		nmap  -p443 -script=ssl-heartbleed $TARGET | tee nmapresults.txt
	fi

if [ -z "$port_3000" ];
	then
		echo -e "$OKRED + -- --=[Port 3000 closed... skipping.$RESET"
	else
		echo -e "$OKBLUE + -- --=[Port 3000 opened... running tests...$RESET"
		nikto -host $TARGET:3000 | tee nikto_assessment.txt
		davtest -url http://$TARGET/ | tee davtestresults.txt
		wpscan --url http://$TARGET/ --enumerate p | tee wpscan.txt
		nmap -p3000 --script=http-adobe-coldfusion-apsa1301 --script=http-affiliate-id --script=http-apache-negotiation --script=http-apache-server-status --script=http-aspnet-debug --script=http-auth-finder --script=http-auth --script=http-backup-finder --script=http-brute --script=http-coldfusion-subzero  --script=http-config-backup --script=http-default-accounts --script=http-frontpage-login --script=http-iis-short-name-brute --script=http-iis-webdav-vuln --script=http-methods --script=http-method-tamper --script=http-passwd --script=http-phpmyadmin-dir-traversal --script=http-php-version --script=http-put --script=http-robots.txt --script=http-server-header --script=http-shellshock --script=http-title --script=http-userdir-enum --script=http-vuln-cve2006-3392 --script=http-vuln-cve2009-3960 --script=http-vuln-cve2010-0738 --script=http-vuln-cve2010-2861 --script=http-vuln-cve2011-3192 --script=http-vuln-cve2011-3368 --script=http-vuln-cve2012-1823 --script=http-vuln-cve2013-0156 --script=http-vuln-cve2013-6786 --script=http-vuln-cve2013-7091 --script=http-vuln-cve2014-2126 --script=http-vuln-cve2014-2127 --script=http-vuln-cve2014-2128 --script=http-vuln-cve2014-2129 --script=http-vuln-cve2014-3704 --script=http-vuln-cve2014-8877 --script=http-vuln-cve2015-1427 --script=http-vuln-cve2015-1635 $TARGET | tee nmapresults.txt
	fi


if [ -z "$port_5000" ];
	then
		echo -e "$OKRED + -- --=[Port 5000 closed... skipping.$RESET"
	else
		echo -e "$OKBLUE + -- --=[Port 5000 opened... running tests...$RESET"
		nikto -host $TARGET:5000 | tee nikto_assessment.txt
		davtest -url http://$TARGET/ | tee davtestresults.txt
		wpscan --url http://$TARGET/ --enumerate p | tee wpscan.txt
		nmap -p5000 --script=http-adobe-coldfusion-apsa1301 --script=http-affiliate-id --script=http-apache-negotiation --script=http-apache-server-status --script=http-aspnet-debug --script=http-auth-finder --script=http-auth --script=http-backup-finder --script=http-brute --script=http-coldfusion-subzero  --script=http-config-backup --script=http-default-accounts --script=http-frontpage-login --script=http-iis-short-name-brute --script=http-iis-webdav-vuln --script=http-methods --script=http-method-tamper --script=http-passwd --script=http-phpmyadmin-dir-traversal --script=http-php-version --script=http-put --script=http-robots.txt --script=http-server-header --script=http-shellshock --script=http-title --script=http-userdir-enum --script=http-vuln-cve2006-3392 --script=http-vuln-cve2009-3960 --script=http-vuln-cve2010-0738 --script=http-vuln-cve2010-2861 --script=http-vuln-cve2011-3192 --script=http-vuln-cve2011-3368 --script=http-vuln-cve2012-1823 --script=http-vuln-cve2013-0156 --script=http-vuln-cve2013-6786 --script=http-vuln-cve2013-7091 --script=http-vuln-cve2014-2126 --script=http-vuln-cve2014-2127 --script=http-vuln-cve2014-2128 --script=http-vuln-cve2014-2129 --script=http-vuln-cve2014-3704 --script=http-vuln-cve2014-8877 --script=http-vuln-cve2015-1427 --script=http-vuln-cve2015-1635 $TARGET | tee nmapresults.txt
	fi


if [ -z "$port_8000" ];
	then
		echo -e "$OKRED + -- --=[Port 8000 closed... skipping.$RESET"
	else
		echo -e "$OKBLUE + -- --=[Port 8000 opened... running tests...$RESET"
		nikto -host $TARGET:8000 | tee nikto_assessment.txt
		davtest -url http://$TARGET/ | tee davtestresults.txt
		wpscan --url http://$TARGET/ --enumerate p | tee wpscan.txt
		nmap -p8000 --script=http-adobe-coldfusion-apsa1301 --script=http-affiliate-id --script=http-apache-negotiation --script=http-apache-server-status --script=http-aspnet-debug --script=http-auth-finder --script=http-auth --script=http-backup-finder --script=http-brute --script=http-coldfusion-subzero  --script=http-config-backup --script=http-default-accounts --script=http-frontpage-login --script=http-iis-short-name-brute --script=http-iis-webdav-vuln --script=http-methods --script=http-method-tamper --script=http-passwd --script=http-phpmyadmin-dir-traversal --script=http-php-version --script=http-put --script=http-robots.txt --script=http-server-header --script=http-shellshock --script=http-title --script=http-userdir-enum --script=http-vuln-cve2006-3392 --script=http-vuln-cve2009-3960 --script=http-vuln-cve2010-0738 --script=http-vuln-cve2010-2861 --script=http-vuln-cve2011-3192 --script=http-vuln-cve2011-3368 --script=http-vuln-cve2012-1823 --script=http-vuln-cve2013-0156 --script=http-vuln-cve2013-6786 --script=http-vuln-cve2013-7091 --script=http-vuln-cve2014-2126 --script=http-vuln-cve2014-2127 --script=http-vuln-cve2014-2128 --script=http-vuln-cve2014-2129 --script=http-vuln-cve2014-3704 --script=http-vuln-cve2014-8877 --script=http-vuln-cve2015-1427 --script=http-vuln-cve2015-1635 $TARGET | tee nmapresults.txt
	fi


if [ -z "$port_8080" ];
	then
		echo -e "$OKRED + -- --=[Port 8080 closed... skipping.$RESET"
	else
		echo -e "$OKBLUE + -- --=[Port 8080 opened... running tests...$RESET"
		nmap -p8080 --script=http-adobe-coldfusion-apsa1301 --script=http-affiliate-id --script=http-apache-negotiation --script=http-apache-server-status --script=http-aspnet-debug --script=http-auth-finder --script=http-auth --script=http-backup-finder --script=http-brute --script=http-coldfusion-subzero  --script=http-config-backup --script=http-default-accounts --script=http-frontpage-login --script=http-iis-short-name-brute --script=http-iis-webdav-vuln --script=http-methods --script=http-method-tamper --script=http-passwd --script=http-phpmyadmin-dir-traversal --script=http-php-version --script=http-put --script=http-robots.txt --script=http-server-header --script=http-shellshock --script=http-title --script=http-userdir-enum --script=http-vuln-cve2006-3392 --script=http-vuln-cve2009-3960 --script=http-vuln-cve2010-0738 --script=http-vuln-cve2010-2861 --script=http-vuln-cve2011-3192 --script=http-vuln-cve2011-3368 --script=http-vuln-cve2012-1823 --script=http-vuln-cve2013-0156 --script=http-vuln-cve2013-6786 --script=http-vuln-cve2013-7091 --script=http-vuln-cve2014-2126 --script=http-vuln-cve2014-2127 --script=http-vuln-cve2014-2128 --script=http-vuln-cve2014-2129 --script=http-vuln-cve2014-3704 --script=http-vuln-cve2014-8877 --script=http-vuln-cve2015-1427 --script=http-vuln-cve2015-1635 $TARGET | tee nmapresults.txt
		nikto -host $TARGET:8080 | tee nikto_assessment.txt
		davtest -url http://$TARGET:8080/ | tee davtestresults.txt
		wpscan --url http://$TARGET/ --enumerate p | tee wpscan.txt
	fi


if [ -z "$port_21" ];
	then
		echo -e "$OKRED + -- --=[Port 21 closed... skipping.$RESET"
	else
		echo -e "$OKORANGE + -- --=[Port 21 opened... running tests...$RESET"
		nmap -A -sV -sC -T5 -p21 --script="ftp-*" $TARGET  | tee nmapresults.txt
	fi

if [ -z "$port_25" ];
	then
		echo -e "$OKRED + -- --=[Port 25 closed... skipping.$RESET"
	else
		echo -e "$OKORANGE + -- --=[Port 25 opened... running tests...$RESET"
		nmap -A -sV -sC -T5 -p25 --script="smtp-vuln-*" $TARGET | tee nmapresults.txt
		smtp-user-enum -M VRFY -U $USER_FILE -t $TARGET 
		smtp-user-enum -M EXPN -U $USER_FILE -t $TARGET 
		smtp-user-enum -M RCPT -U $USER_FILE -t $TARGET 
	fi


if [ -z "$port_161" ];
then
	echo -e "$OKRED + -- --=[Port 161 closed... skipping.$RESET"
else
	echo -e "$OKORANGE + -- --=[Port 161 opened... running tests...$RESET"
	for a in `cat $SNMP_STRINGS`; do snmp-check -t $TARGET -c $a; done;
	nmap -sU -p 161 --script="snmp*" $TARGET | tee nmapresults.txt
fi

if [ -z "$port_162" ];
then
	echo -e "$OKRED + -- --=[Port 162 closed... skipping.$RESET"
else
	echo -e "$OKORANGE + -- --=[Port 162 opened... running tests...$RESET"
	for a in `cat $SNMP_STRINGS`; do snmp-check -t $TARGET -c $a; done;
	nmap -A -p 162 --script="snmp*" $TARGET | tee nmapresults.txt
fi

if [ -z "$port_110" ];
then
	echo -e "$OKRED + -- --=[Port 110 closed... skipping.$RESET"
else
	echo -e "$OKORANGE + -- --=[Port 110 opened... running tests...$RESET"
	nmap -A -sV -T5 --script="pop3--capabilities" --script="pop3-ntlm-info" -p 110 $TARGET | tee nmapresults.txt
fi

if [ -z "$port_111" ];
then
	echo -e "$OKRED + -- --=[Port 111 closed... skipping.$RESET"
else
	echo -e "$OKORANGE + -- --=[Port 111 opened... running tests...$RESET"
	showmount -a $TARGET
	showmount -d $TARGET
	showmount -e $TARGET
fi

if [ -z "$port_135" ];
then
	echo -e "$OKRED + -- --=[Port 135 closed... skipping.$RESET"
else
	echo -e "$OKORANGE + -- --=[Port 135 opened... running tests...$RESET"
	rpcinfo -p $TARGET | tee RPCresults.txt
	nmap -A -p 135 -T5 --script="rpc*" $TARGET | tee nmapresults.txt
fi


if [ -z "$port_445" ];
	then
		echo -e "$OKRED + -- --=[Port 445 closed... skipping.$RESET"
			if [ -z "$port_139" ];
				then
			echo -e "$OKRED + -- --=[Port 139 closed... skipping.$RESET"
				else
			echo -e "$OKORANGE + -- --=[Port 139 opened... running tests...$RESET"
			enum4linux -a $TARGET | tee E4Lresults.txt
			nmap -p139 $TARGET --script="smb-vuln*"	 | tee nmapresults.txt
			fi
	else
		echo -e "$OKORANGE + -- --=[Port 445 opened... running tests...$RESET"
		enum4linux -a $TARGET | tee E4Lresults.txt
		nmap -p445 $TARGET --script="smb-vuln*"	 | tee nmapresults.txt
	fi

if [ -z "$port_2121" ];
then
	echo -e "$OKRED + -- --=[Port 2121 closed... skipping.$RESET"
else
	echo -e "$OKORANGE + -- --=[Port 2121 opened... running tests...$RESET"
	nmap -A -sV -T5 --script="ftp-*" -p2121 $TARGET | tee nmapresults.txt
	fi

if [ -z "$port_3306" ];
then
	echo -e "$OKRED + -- --=[Port 3306 closed... skipping.$RESET"
else
	echo -e "$OKORANGE + -- --=[Port 3306 opened... running tests...$RESET"
	nmap -A -sV --script="mysql*" -p 3306 $TARGET | tee nmapresults.txt
	mysql -u root -h $TARGET -e 'SHOW DATABASES; SELECT Host,User,Password FROM mysql.user;' | tee mysql.txt
fi

echo -e "$OKGREEN + -- -- Starting UDP Scan .$RESET"
us -H -mU -Iv $TARGET -p 1-65535

if [ -z "$port_21" ];
	then
		echo -e "$OKRED + -- --=[Port 21 closed... skipping brute force.$RESET"
	else
		echo -e "$OKORANGE + -- --=[Port 21  start brute force......$RESET"
		medusa -h $TARGET -U $USER_FILE -P $MIN_PASS -e ns -M ftp -v 1 | tee medusabrute.txt	
	fi

if [ -z "$port_22" ];
	then
		echo -e "$OKRED + -- --=[Port 22 closed... skipping brute force.$RESET"
	else
		echo -e "$OKORANGE + -- --=[Port 22 opened...  start brute force...$RESET"
		medusa -h $TARGET -U $USER_FILE -P $MIN_PASS -e ns -M ssh -v 1 | tee medusabrute.txt
	fi


if [ -z "$port_445" ];
	then
		echo -e "$OKRED + -- --=[Port 445 closed... skipping brute force.$RESET"
	else
		echo -e "$OKORANGE + -- --=[Port 445 opened...  start brute force...$RESET"
		medusa -h $TARGET -U $USER_FILE -P $MIN_PASS -e ns -M SMBNT -v 1 | tee medusabrute.txt
		echo -e "$OKRED + -- -- If anon login allowed use the nmap brute force below...$RESET"
		#nmap -p445 --script=smb-brute --script-args smblockout=true,userdb=$USER_FILE,passdb=$MIN_PASS $TARGET
	fi

if [ -z "$port_3389" ];
	then
		echo -e "$OKRED + -- --=[Port 3389 closed... skipping brute force.$RESET"
	else
		echo -e "$OKORANGE + -- --=[Port 3389 opened...  start brute force...$RESET"
		rdesktop $TARGET &
		medusa -h $TARGET -U $USER_FILE -P $MIN_PASS -e ns -M RDP -v 1 | tee medusabrute.txt
	fi

if [ -z "$port_80" ];
	then
		echo -e "$OKRED + -- --=[Port 80 closed... skipping extensive directory browsing.$RESET"
	else
		echo -e "$OKORANGE + -- --=[Port 80 opened... running extensive directory browsing...$RESET"
		dirb http://$TARGET/ $DIRB_DIR -w -r  | tee dirbscan.txt
	fi


if [ -z "$port_443" ];
	then
		echo -e "$OKRED + -- --=[Port 443 closed... skipping extensive directory browsing.$RESET"
	else
		echo -e "$OKORANGE + -- --=[Port 443 opened... running extensive directory browsing...$RESET"
		dirb https://$TARGET:443/ $DIRB_DIR -w -r | tee dirbscan.txt
	fi

if [ -z "$port_3000" ];
	then
		echo -e "$OKRED + -- --=[Port 3000 closed... skipping extensive directory browsing.$RESET"
	else
		echo -e "$OKORANGE + -- --=[Port 3000 opened... running extensive directory browsing...$RESET"
		dirb http://$TARGET:3000/ $DIRB_DIR -w -r | tee dirbscan.txt
	fi

if [ -z "$port_5000" ];
	then
		echo -e "$OKRED + -- --=[Port 5000 closed... skipping extensive directory browsing.$RESET"
	else
		echo -e "$OKORANGE + -- --=[Port 5000 opened... running extensive directory browsing...$RESET"
		dirb http://$TARGET:5000/ $DIRB_DIR -w -r | tee dirbscan.txt
	fi

if [ -z "$port_8000" ];
	then
		echo -e "$OKRED + -- --=[Port 8000 closed... skipping extensive directory browsing.$RESET"
	else
		echo -e "$OKORANGE + -- --=[Port 8000 opened... running extensive directory browsing...$RESET"
		dirb http://$TARGET:8000/ $DIRB_DIR -w -r | tee dirbscan.txt
	fi

if [ -z "$port_8080" ];
	then
		echo -e "$OKRED + -- --=[Port 8080 closed... skipping extensive directory browsing.$RESET"
	else
		echo -e "$OKORANGE + -- --=[Port 8080 opened... running extensive directory browsing...$RESET"
		dirb http://$TARGET:8080/ $DIRB_DIR -w -r | tee dirbscan.txt
	fi
