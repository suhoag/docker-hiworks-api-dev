#!/bin/bash

set -e

service php$PHP_VERSION-fpm start

/usr/sbin/apache2ctl -DFOREGROUND

exec "$@"