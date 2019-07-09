#!/bin/bash

set -e

service php7.2-fpm start

exec apache2ctl -DFOREGROUND
