FROM ubuntu:19.04

MAINTAINER Haesung Hwang <suhoag@naver.com>

# 업데이트 및 모듈 설치
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get  install apt-utils software-properties-common tzdata apache2 vim -y && \
    ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime && \
    add-apt-repository ppa:ondrej/php -y && \
    apt-get update && apt upgrade -y && \
    apt-get install php5.6 php5.6-fpm php5.6-mysql php5.6-mbstring php5.6-zip php5.6-xml php5.6-pgsql php-xdebug php-memcache php-memcached -y -y

# php.ini 에 xdebug 설정 추가
RUN echo "xdebug.remote_enable=true" >> /etc/php/5.6/fpm/php.ini && \
    echo "xdebug.remote_connect_back=true" >> /etc/php/5.6/fpm/php.ini && \
    echo "xdebug.idekey=PHPSTORM" >> /etc/php/5.6/fpm/php.ini && \
    sed -i 's/;date.timezone =/date.timezone = Asia\/Seoul/g' /etc/php/5.6/fpm/php.ini && \
    sed -i 's/short_open_tag = Off/short_open_tag = On/g' /etc/php/5.6/fpm/php.ini && \
    sed -i 's/error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT/error_reporting = E_ALL/g' /etc/php/5.6/fpm/php.ini && \
    sed -i 's/display_errors = Off/display_errors = On/g' /etc/php/5.6/fpm/php.ini

# composer 설치
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');" && \
    mv composer.phar /usr/bin/composer

#apache 모듈 활성화
RUN a2enmod proxy_fcgi setenvif rewrite ssl && a2enconf php5.6-fpm

#볼륨 경로 생성(인증서)
RUN mkdir /etc/apache2/certificate

# 정리
RUN apt-get autoremove && apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    rm -fr /etc/apache2/sites-enabled/*

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

VOLUME ["/var/www", "/etc/apache2/sites-available", "/etc/apache2/certificate"]
EXPOSE 80 443