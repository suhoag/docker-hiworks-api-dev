FROM ubuntu:19.04

# 업데이트 및 모듈 설치
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get  install apt-utils software-properties-common tzdata apache2 vim -y && \
    ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime && \
    add-apt-repository ppa:ondrej/php -y && \
    apt-get update && apt upgrade -y && \
    apt-get install php7.2 php7.2-fpm php7.2-mysql php7.2-mbstring php7.2-zip php7.2-xml php-xdebug php-memcache php-memcached -y

# composer 설치
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');" && \
    mv composer.phar /usr/bin/composer

# php.ini 에 xdebug 설정 추가
RUN echo "xdebug.remote_enable=true" >> /etc/php/7.2/fpm/php.ini && \
    echo "xdebug.remote_connect_back=true" >> /etc/php/7.2/fpm/php.ini && \
    echo "xdebug.idekey=PHPSTORM" >> /etc/php/7.2/fpm/php.ini && \
    sed -i 's/;date.timezone =/date.timezone = Asia\/Seoul/g' /etc/php/7.2/fpm/php.ini && \
    sed -i 's/error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT/error_reporting = E_ALL/g' /etc/php/7.2/fpm/php.ini && \
    sed -i 's/display_errors = Off/display_errors = On/g' /etc/php/7.2/fpm/php.ini

#apache 모듈 활성화
RUN a2enmod proxy_fcgi setenvif rewrite ssl && a2enconf php7.2-fpm

#볼륨 경로 생성(인증서)
RUN mkdir /etc/apache2/certificate

# 정리
RUN apt-get autoremove && apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    rm -fr /etc/apache2/sites-enabled/*

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

VOLUME ["/var/www", "/etc/apache2/sites-enabled", "/etc/apache2/certificate"]
EXPOSE 80 443