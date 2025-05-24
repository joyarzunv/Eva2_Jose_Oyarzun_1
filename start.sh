#!/bin/bash
service apache2 start
/usr/local/nagios/bin/nagios /usr/local/nagios/etc/nagios.cfg
tail -f /var/log/apache2/access.log

