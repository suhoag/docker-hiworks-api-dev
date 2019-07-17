#!/bin/bash

set -e

service php7.2-fpm start

/usr/sbin/apache2ctl -DFOREGROUND

exec "$@"