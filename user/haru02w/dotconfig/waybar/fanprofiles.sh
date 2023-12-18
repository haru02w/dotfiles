#!/bin/sh
RETURN=$(asusctl profile -p)

if [[ $RETURN = *"Performance"* ]]
then
	echo "󰑮"
elif [[ $RETURN = *"Balanced"* ]]
then
	echo "󰜎"
elif [[ $RETURN = *"Quiet"* ]]
then
	echo ""
fi
