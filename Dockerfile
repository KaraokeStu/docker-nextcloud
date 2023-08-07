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
 libsmbclient-dev \
 python3-pip

RUN docker-php-ext-configure imap --with-kerberos --with-imap-ssl
RUN docker-php-ext-install bz2 imap 
RUN pecl install smbclient
RUN pecl install inotify
RUN docker-php-ext-enable smbclient
RUN docker-php-ext-enable inotify

RUN python3 -m pip install numpy --break-system-packages
RUN python3 -m pip install Pillow --break-system-packages
RUN python3 -m pip install scipy --break-system-packages
RUN python3 -m pip install pywavelets --break-system-packages
RUN python3 -m pip install asn1crypto --break-system-packages
RUN python3 -m pip install pynacl --break-system-packages
RUN python3 -m pip install cryptography --break-system-packages
RUN python3 -m pip install pillow_heif --break-system-packages
RUN python3 -m pip install hexhamming --break-system-packages
