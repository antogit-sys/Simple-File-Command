#!/bin/bash

echo "Install requirements.txt ..."

pip3 install -r requirements.txt --break-system-packages
sleep 1
clear

echo "Run:"
echo "\$ python3 sfile.py"
python3 sfile.py
sleep 3
clear

echo "Run:"
echo "\$ python3 sfile.py test/* nothing"
python3 sfile.py test/* nothing
sleep 1
