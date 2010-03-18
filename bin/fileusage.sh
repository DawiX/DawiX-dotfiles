#!/usr/bin/sh
exec  conky -c .conkybottom | dzen2 -x '371' -y '-1' -w '300' -h '16' -bg '#080808' -fg '#b0b0b0' -ta 'c' -tw '48' -l '7' -fn '-*-terminus-medium-r-*-*-12-*-*-*-*-*-*-*' -e 'button1=togglecollapse;button2=exit:13'
