#!/bin/bash
#
# SABnzbd Stats
#
# Dave Schmid, dave@pulpfree.org
#
# version 0.2 - 2020-10-02 - Updated metrics to include day, week, month
# version 0.1 - 2020-06-05
#

#!/bin/bash

server_stats="$(curl -s "http://media.tylephony.com/sabnzbd/api?output=json&apikey=APIKEY&mode=server_stats")"
queue_stats="$(curl -s "http://media.tylephony.com/sabnzbd/api?output=json&apikey=APIKEY&mode=queue")"

# Server 1

server1_total=$(echo "${server_stats}" |jq .servers[].total | head -1)
server1_month=$(echo "${server_stats}" |jq .servers[].month | head -1)
server1_week=$(echo "${server_stats}" |jq .servers[].week | head -1)
server1_day=$(echo "${server_stats}" |jq .servers[].day | head -1)

# Server 2

server2_total=$(echo "${server_stats}" |jq .servers[].total | tail -1)
server2_month=$(echo "${server_stats}" |jq .servers[].month | tail -1)
server2_week=$(echo "${server_stats}" |jq .servers[].week | tail -1)
server2_day=$(echo "${server_stats}" |jq .servers[].day | tail -1)

# Total

bytes_total=$(echo "${server_stats}" |jq .total)

queue_status=$(echo "${queue_stats}" | jq -r .queue.status)
queue_no_of_slots=$(echo "${queue_stats}" | jq -r .queue.noofslots_total)

echo "server_stats,server_name=news-eu.newshosting.com,range=Total bytes_total=${server1_total}
server_stats,server_name=news-eu.newshosting.com,range=Month bytes_total=${server1_month}
server_stats,server_name=news-eu.newshosting.com,range=Week bytes_total=${server1_week}
server_stats,server_name=news-eu.newshosting.com,range=Day bytes_total=${server1_day}
server_stats,server_name=news.newshosting.com,range=Total bytes_total=${server2_total}
server_stats,server_name=news.newshosting.com,range=Month bytes_total=${server2_month}
server_stats,server_name=news.newshosting.com,range=Week bytes_total=${server2_week}
server_stats,server_name=news.newshosting.com,range=Day bytes_total=${server2_day}
server_stats,server_name=Total,range=Total bytes_total=${bytes_total}
queue_stats status=\"${queue_status}\",no_of_slots=${queue_no_of_slots}"
