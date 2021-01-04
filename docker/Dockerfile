FROM php:7.4.7-apache

RUN apt-get update && \
    # install packages
    apt-get install -y --no-install-recommends \
      git \
      vim \
      unzip \
      mariadb-client \
      libonig-dev \
      libzip-dev \
      libfreetype6-dev \
      libjpeg62-turbo-dev \
      libpng-dev \
      libwebp-dev && \
    # configure GD
    docker-php-ext-configure gd --with-jpeg --with-webp --with-freetype && \
    # install php extensions
    docker-php-ext-install -j$(nproc) \
      pdo_mysql \
      mysqli \
      mbstring \
      zip \
      gd \
      exif && \
    # reduce image size
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# composer
COPY --from=composer:2.0.8 /usr/bin/composer /usr/bin/composer

# node
COPY --from=node /usr/local/bin/ /usr/local/bin/
COPY --from=node /usr/local/lib/node_modules /usr/local/lib/node_modules

# enable apache mods
RUN a2enmod rewrite headers

# mhsendmail for Mailhog
RUN curl -sSL https://github.com/mailhog/mhsendmail/releases/download/v0.2.0/mhsendmail_linux_amd64 -o mhsendmail && \
    mv mhsendmail /usr/local/bin/mhsendmail && \
    chmod +x /usr/local/bin/mhsendmail

# create devuser with the same UID/GID as the host
ARG uid
RUN useradd -G www-data,root -u $uid -d /home/devuser devuser && \
    usermod -G devuser www-data
RUN mkdir -p /home/devuser/.composer && \
    chown -R devuser:devuser /home/devuser

# enable colorized ls
COPY .bashrc /root/
COPY --chown=devuser:devuser .bashrc /home/devuser/
