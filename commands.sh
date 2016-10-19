#!/bin/bash
 
# read in variables
read nick chan saying

# function for replying
function say { echo "PRIVMSG $1 :$2" ; }

# function for doing stuff
function action { echo "ACTION $1 :$2" ; }

# function for parsing
function has { $(echo "$1" | grep -P "$2" > /dev/null) ; }

# scan for keywords
if [[ $chan == "#support" ]] ; then
        if grep $nick joined.txt ; then
                message=$(cat message.txt)
                say "#hack" "Deskcats: Check #support."
                # say "#support" "$nick: $message"
                sed -i "/$nick/d" ./joined.txt
        fi
fi
