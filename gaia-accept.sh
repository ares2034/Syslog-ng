#!/bin/bash
message="Starting logging"

while read line ; do
## define a parameter for the initial 
temp=$line

## if the previous message and the current message do nnot have the string "times", write message with count=1.
if [[ $temp != *times* && $message != *times* ]]
then
#echo "Case 1"
echo $message count=1>> /var/log/securitylog/gaia-droplog
## store current message to the message parameter.
message="$line"

## if the previous message includes the string "times" and current message does not have times, then store current message to the message parameter.  
elif [[ $temp != *times* && $message == *times* ]]
then
#echo "Case2"
message="$line"
## In other case, merge previous message and current message as one message.
else 
reptimes=`echo "$line" | rev | cut -d " " -f 7 | rev`
## Add 1 to the reptimes to correct repeated number.
reptimes2=`expr "$reptimes" "+" "1"`
#echo "Case 3"
echo $message count=$reptimes2 >> /var/log/securitylog/gaia-acceptlog
message="$line"
fi

done
