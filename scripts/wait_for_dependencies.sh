echo $PATH | grep ~/bin
export PATH=~/bin:$PATH

authip=$1
waitlist=$2
port=4502
for i in $(echo $waitlist | sed "s/,/ /g")
do
	TIMELIMIT=$((SECONDS+#{node[:aem][:timeout]}))
	echo "Waiting for server validation.  Ctrl+C to skip.";
	until $(curl --silent "http://$authip:$port/libs/granite/core/content/login.html" |grep "QUICKSTART_HOMEPAGE" >/dev/null); do
					printf '.';
					sleep 2;
					if [ $SECONDS -gt $TIMELIMIT ]; then
									echo "";
									echo "Waited ${SECONDS} seconds however validation has failed.  Exiting now.";
									exit
					fi
	done
	echo "";
	echo "Startup completed successfully in ${SECONDS} seconds";
done
status=""
