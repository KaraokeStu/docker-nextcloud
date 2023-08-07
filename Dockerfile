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

# Install pipx, which we use to install other python tools.
ENV PIPX_BIN_DIR=/usr/local/bin
ENV PIPX_DEFAULT_PYTHON=/usr/bin/python3
RUN python3 -m venv /opt/pipx-venv \
    && /opt/pipx-venv/bin/pip install --no-cache-dir pipx \
    && ln -s /opt/pipx-venv/bin/pipx /usr/local/bin/

# We don't use the ubuntu virtualenv package because it unbundles pip dependencies
# in virtualenvs it create.
RUN pipx install --pip-args="--no-cache-dir" virtualenv


RUN pipx install --pip-args="--no-cache-dir" numpy pillow
RUN pipx install --pip-args="--no-cache-dir" scipy pywavelets
RUN pipx install --pip-args="--no-cache-dir" asn1crypto
RUN pipx install --pip-args="--no-cache-dir" pynacl cryptography
RUN pipx install --pip-args="--no-cache-dir" pillow_heif
RUN pipx install --pip-args="--no-cache-dir" hexhamming
