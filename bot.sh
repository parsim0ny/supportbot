#!/usr/bin/env bash

# Need a connection to the IRC server, and be parsing
# what is happening in the window.

# say function also used in commands.sh
function say { echo "PRIVMSG $1 :$2" ; }

key=`cat $1`
function send {
        echo "-> $1"
        echo "$1" >> .botfile
}

# Create a fresh run file
rm .botfile
rm whois.txt
mkfifo .botfile

# Establish/maintain connection to the server
tail -f .botfile | openssl s_client -connect irc.cat.pdx.edu:6697 | while true; do
        if [[ -z $started ]] ; then
                send "NICK SupportBot"
                send "USER 0 0 0 :SupportBot"
                send "JOIN #hack $key"
                send "JOIN #support"
                send "JOIN #bots $key"
                started="yes"
        fi
        read irc
        day=$(date +%u)
        hour=$(date +%H)
        echo $day $hour > time.txt
        ./timeConvert > message.txt
        echo "<- $irc" | tee last_input.txt
        if `echo $irc | cut -d ' ' -f 1 | grep PING > /dev/null` ; then
                send "PONG"
        elif `echo $irc | grep PRIVMSG > /dev/null` ; then
                echo $irc > last_message.txt
                chan=`echo $irc | cut -d ' ' -f 3`
                identity=`echo $irc | cut -d ' ' -f 1-3`
                saying=`echo ${irc##$identity :}|tr -d "\r\n"`
                nick="${irc%%!*}"; nick="${nick#:}"
                var=`echo $nick $chan $saying | ./commands.sh`
                search="$(echo $saying | cut -f 2 -d ' ')"
                if [[ ! -z $var ]] ; then
                        send "$var"
                fi
        else
                echo $irc >> whois.txt
                if grep "JOIN" last_input.txt > /dev/null ; then
                        user_full=$(cat last_input.txt | cut -d ' ' -f 2)
                        user_half=$(echo $user_full | cut -d '!' -f 1)
                        user=$(echo $user_half | cut -d ':' -f 2)
                        echo $user >> joined.txt
                        send "WHOIS $user $user"
                fi
                if grep "#hack" whois.txt > /dev/null ; then
                        sed -i "/$user/d" ./joined.txt
                        > whois.txt
                fi
                if grep "End of /WHOIS" whois.txt > /dev/null ; then
                        > whois.txt
                        echo test
                fi
        fi

done



