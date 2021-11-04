#/bin/bash

if [ $auth = 0 ]; then
    notify-send "Swap is disabled"
fi

echo "Disabling swap in a loop"
while :
do
	echo "Press CTRL+C to exit"
	swapoff -a
	sleep 10
done
