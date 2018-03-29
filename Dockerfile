FROM nginx
MAINTAINER Mark Myers <marcusmyers@gmail.com>

ENV php_conf=/etc/php/7.0/fpm/php.ini \
    fpm_conf=/etc/php/7.0/fpm/php-fpm.conf \
    fpm_pool=/etc/php/7.0/fpm/pool.d/www.conf

EXPOSE 80

ADD https://www.dotdeb.org/dotdeb.gpg /tmp/

RUN echo 'deb http://packages.dotdeb.org jessie all' >> /etc/apt/sources.list && \
    echo 'deb-src http://packages.dotdeb.org jessie all' >> /etc/apt/sources.list && \
    apt-key add /tmp/dotdeb.gpg && \
    rm /tmp/dotdeb.gpg && \
    apt-get update && \
    apt-get -y install \
      php7.2-fpm \
      php7.2-json \
      php7.2-mysql \
      php7.2-gd \
      php7.2-curl \
      mysql-client \
      supervisor && \
    apt-get -q clean && \
    rm -rf /var/lib/apt/lists/*

COPY config/docker/nginx.conf /etc/nginx/nginx.conf
COPY config/docker/wordpress.conf.tpl /etc/nginx/wordpress.conf.tpl
COPY config/docker/start /etc/nginx/start
COPY config/docker/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# tweak php-fpm config
RUN sed -i \
        -e "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g" \
        ${php_conf} && \
     sed -i \
        -e "s/;daemonize\s*=\s*yes/daemonize = no/g" \
        ${fpm_conf} && \
     sed -i \
        -e "s/;catch_workers_output\s*=\s*yes/catch_workers_output = yes/g" \
        -e "s/^;clear_env = no$/clear_env = no/" \
        ${fpm_pool}

CMD ["/usr/bin/supervisord"]
