FROM php:7.0-fpm

ENV PHP_EXPOSE off
ENV PHP_LOG_ERRORS 1
ENV PHP_LOG_ERRORS_MAX 0
ENV PHP_DISPLAY_ERRORS 0

# install the PHP extensions we need
RUN set -ex; \
	\
	apt-get update; \
	apt-get install -y \
		libjpeg-dev \
		libpng12-dev \
	; \
	rm -rf /var/lib/apt/lists/*; \
	\
	docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr; \
	docker-php-ext-install gd mysqli opcache
# TODO consider removing the *-dev deps and only keeping the necessary lib* packages

# set recommended PHP.ini settings
# see https://secure.php.net/manual/en/opcache.installation.php
RUN { \
		echo 'opcache.memory_consumption=128'; \
		echo 'opcache.interned_strings_buffer=8'; \
		echo 'opcache.max_accelerated_files=4000'; \
		echo 'opcache.revalidate_freq=2'; \
		echo 'opcache.fast_shutdown=1'; \
		echo 'opcache.enable_cli=1'; \
	} > /usr/local/etc/php/conf.d/opcache-recommended.ini \
    && { \
		echo 'expose_php=${PHP_EXPOSE}'; \
        echo 'log_errors=${PHP_LOG_ERRORS}'; \
        echo 'log_errors_max_len=${PHP_LOG_ERRORS_MAX}'; \
        echo 'display_errors=${PHP_DISPLAY_ERRORS}'; \
        echo 'error_log=/var/log/php/error.log'; \
    } > /usr/local/etc/php/conf.d/default.ini \
    && mkdir /var/log/php \
	&& ln -sf /dev/stderr /var/log/php/error.log

VOLUME /var/www/html

ENV WORDPRESS_VERSION 4.7.5
ENV WORDPRESS_SHA1 fbe0ee1d9010265be200fe50b86f341587187302

RUN set -ex; \
	curl -o wordpress.tar.gz -fSL "https://wordpress.org/wordpress-${WORDPRESS_VERSION}.tar.gz"; \
	echo "$WORDPRESS_SHA1 *wordpress.tar.gz" | sha1sum -c -; \
# upstream tarballs include ./wordpress/ so this gives us /usr/src/wordpress
	tar -xzf wordpress.tar.gz -C /usr/src/; \
	rm wordpress.tar.gz; \
	chown -R www-data:www-data /usr/src/wordpress

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["php-fpm"]
VOLUME ["/var/www/html"]
