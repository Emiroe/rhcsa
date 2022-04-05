#!/bin/bash

VAR=$(ls ./practice-tasks | sort -R | tail -n 1)
echo "############################"
echo $VAR
echo "############################"
head -n 10 ./practice-tasks/$VAR | sed -E 's#<br/># #g'

