#!/bin/bash

echo $RANDOM > rand.txt
for ((i=0;i<=$1;i++))
do
  echo $RANDOM >> rand.txt
done
echo "Fertig :P"
