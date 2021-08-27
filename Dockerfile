FROM nextcloud:latest

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y --no-install-recommends --fix-missing \
 ffmpeg \
 libmagickcore-6.q16-6-extra \
 procps \
 smbclient \
 inotify-tools \
 libbz2-dev \
 libc-client-dev \
 libkrb5-dev \
 libsmbclient-dev

RUN docker-php-ext-configure imap --with-kerberos --with-imap-ssl
RUN docker-php-ext-install bz2 imap 
RUN pecl install smbclient
RUN pecl install inotify
RUN docker-php-ext-enable smbclient
RUN docker-php-ext-enable inotify
