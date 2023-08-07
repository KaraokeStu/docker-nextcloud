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
 python3-full \
 python3-pip \
 python3-venv \
 python3-virtualenv

RUN docker-php-ext-configure imap --with-kerberos --with-imap-ssl
RUN docker-php-ext-install bz2 imap 
RUN pecl install smbclient
RUN pecl install inotify
RUN docker-php-ext-enable smbclient
RUN docker-php-ext-enable inotify

# Install pipx, which we use to install other python tools.
RUN python3 -m pip install pipx --break-system-packages
RUN python3 -m pipx ensurepath

RUN pipx install numpy pillow
RUN pipx install scipy pywavelets
RUN pipx install asn1crypto
RUN pipx install pynacl cryptography
RUN pipx install pillow_heif
RUN pipx install hexhamming
