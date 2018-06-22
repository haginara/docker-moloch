#!/bin/sh

MOLOCHDIR=/data/moloch

USERNAME=admin
PASSWORD=test

echo "Giving ES time to start..."
until curl -sS 'http://elasticsearch:9200/_cluster/health?wait_for_status=yellow&timeout=5s'; \
	do echo "Waiting for ES to start"; sleep 1; done

# intialize moloch
echo "Init DB"
echo INIT | /data/moloch/db/db.pl http://elasticsearch:9200 init
/data/moloch/bin/moloch_add_user.sh "$USERNAME" "Admin User" "$PASSWORD" --admin
/data/moloch/bin/moloch_update_geo.sh

echo "Starting capture on existing pcap folder. Change /data/moloch/etc/config.ini"
nohup /data/moloch/bin/moloch-capture -R /data/pcap &

cd /data/moloch/viewer

echo
echo "PLEASE ignore error about mising log file. It's standard moloch start script"
echo "You can add more pcap files to /data/pcap. After put pcap files"
echo "Starting viewer. Go with https to port 8005 of container."
$MOLOCHDIR/bin/node viewer.js -c $MOLOCHDIR/etc/config.ini #>> $MOLOCHDIR/logs/viewer.log 2>&1'
