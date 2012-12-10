#!/bin/bash

echo Copying Files
cp .bash_aliases ~/
cp .screenrc ~/
cp .screen_hardstatus ~/
cp .vimrc ~/
echo making screen script +x
chmod +x ~/.screen_hardstatus
echo making the screenlogs dir
mkdir ~/screenlogs
echo done
