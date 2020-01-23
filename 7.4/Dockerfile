FROM suhoag/hiworks-api-apahe-dev

ENV PHP_VERSION 7.4

# 업데이트 및 모듈 설치
RUN apt-get update && \
    apt-get install php$PHP_VERSION php$PHP_VERSION-fpm php$PHP_VERSION-mysql php$PHP_VERSION-mbstring php$PHP_VERSION-zip php$PHP_VERSION-xml php-xdebug php-memcache php-memcached -y

# composer 설치
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');" && \
    mv composer.phar /usr/bin/composer

# php.ini 에 xdebug 설정 추가
RUN echo "xdebug.remote_enable=true" >> /etc/php/$PHP_VERSION/fpm/php.ini && \
    echo "xdebug.remote_connect_back=true" >> /etc/php/$PHP_VERSION/fpm/php.ini && \
    echo "xdebug.idekey=PHPSTORM" >> /etc/php/$PHP_VERSION/fpm/php.ini && \
    sed -i 's/;date.timezone =/date.timezone = Asia\/Seoul/g' /etc/php/$PHP_VERSION/fpm/php.ini && \
    sed -i 's/error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT/error_reporting = E_ALL/g' /etc/php/$PHP_VERSION/fpm/php.ini && \
    sed -i 's/display_errors = Off/display_errors = On/g' /etc/php/$PHP_VERSION/fpm/php.ini

#apache php-fpm 설정 활성화
RUN a2enconf php$PHP_VERSION-fpm

# 정리
RUN apt-get autoremove -y && apt-get clean -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    rm -fr /etc/apache2/sites-enabled/*

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

VOLUME ["/var/www", "/etc/apache2/sites-enabled", "/etc/apache2/certificate"]
EXPOSE 80 443