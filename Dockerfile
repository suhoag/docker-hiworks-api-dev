FROM ubuntu:19.04

MAINTAINER Haesung Hwang <suhoag@naver.com>

# 업데이트 및 모듈 설치
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install software-properties-common tzdata apache2 -y && \
    ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime && \
    add-apt-repository ppa:ondrej/php -y && \
    apt-get update && apt upgrade -y && \
    apt-get install php7.2 php7.2-fpm php7.2-mysql php7.2-mbstring php7.2-xml php-xdebug php-memcache -y

# composer 설치
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');" && \
    mv composer.phar /usr/bin/composer

RUN echo "xdebug.remote_enable=true" >> /etc/php/7.2/fpm/php.ini && \
    echo "xdebug.remote_connect_back=true" >> /etc/php/7.2/fpm/php.ini && \
    echo "xdebug.idekey=PHPSTORM" >> /etc/php/7.2/fpm/php.ini

RUN a2enmod proxy_fcgi && a2enmod rewrite

# 설정 디렉토리
RUN mkdir /www

# 정리
RUN apt-get autoremove && apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME ["/www", "/etc/apache2/sites-available"]
EXPOSE 80 443