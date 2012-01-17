#!/bin/bash

echo $RANDOM > rand.txt
for i in {0..100000} 
do
  echo $RANDOM >> rand.txt
done
echo "Fertig :P"
