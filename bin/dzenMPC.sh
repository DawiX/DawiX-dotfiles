#!/bin/sh
#
#
#
# (c) 2007, by Jochen Schweizer
# with help from Robert Manea
 
FN='-artwiz-snap-*-*-*-*-8-*-*-*-*-*-*-*'
BG='#222222'
FG='#daff30'
W=400
X=0
Y=900
GH=7
GW=50
GFG='#daff30'
GBG='#111'
FW="mpc seek +5"      # 5 sec forwards
RW="mpc seek -5"      # 5 sec backwards
NEXTS="mpc next"      # previous song
PREVS="mpc prev"      # next song
TOGGS="mpc toggle"    # play/pause
 
CAPTION="^i(/home/deifl/bitmaps/music.xbm)"
 
MAXPOS="100"
 
while true; do
  POS=`mpc | sed -ne 's/^.*(\([0-9]*\)%).*$/\1/p'`
  POSM="$POS $MAXPOS"
  echo -n "$CAPTION "
  echo "`mpc | sed -n '1p'`" | tr '\n' ' '
  echo "$POSM" | gdbar -h $GH -w $GW -fg $GFG -bg $GBG
  sleep 1;
done | dzen2 -ta l -tw $W -x $X -y $Y -fg $FG -bg $BG -fn $FN -e "button4=exec:$RW;button5=exec:$FW;button1=exec:$PREVS;button3=exec:$NEXTS;button2=exit"
