#!/bin/bash

set -e

service php5.6-fpm start

/usr/sbin/apache2ctl -DFOREGROUND

exec "$@"