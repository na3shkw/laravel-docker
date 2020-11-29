#!/bin/bash

uidtext="UID=$UID"
match=$(grep ^UID=.+$ -oP .env)
if [ $? = 0 ]; then
	sed -i -e "s/$match/$uidtext/g" .env
else
	echo $uidtext >> .env
fi
