#Lambda base image Amazon linux
FROM public.ecr.aws/lambda/provided as builder 
# Set desired PHP Version
ARG php_version="8.0.2"
RUN yum clean all && \
    yum install -y autoconf \
                bison \
                bzip2-devel \
                gcc \
                gcc-c++ \
                git \
                gzip \
                libcurl-devel \
                libxml2-devel \
                make \
                openssl-devel \
                tar \
                unzip \
                zip \
                re2c \
                sqlite-devel \
                oniguruma-devel

# Download the PHP source, compile, and install both PHP and Composer
RUN curl -sL https://github.com/php/php-src/archive/php-${php_version}.tar.gz | tar -xvz && \
    cd php-src-php-${php_version} && \
    ./buildconf --force && \
    ./configure --prefix=/var/lang/ --with-openssl --with-curl --with-zlib --with-pear --enable-bcmath --enable-sockets --with-bz2 --enable-mbstring --with-pdo-mysql --with-mysqli  && \
    make -j 12 && \
    make install && \
    /var/lang/bin/php -v && \
    curl -sS https://getcomposer.org/installer | /var/lang/bin/php -- --install-dir=/var/lang/bin/ --filename=composer

RUN printf "yes\nyes\nyes\nyes\n" | /var/lang/bin/pecl install swoole

# Install Guzzle, prepare vendor files
RUN mkdir /lambda-php-vendor && \
    cd /lambda-php-vendor && \
    /var/lang/bin/php /var/lang/bin/composer require guzzlehttp/guzzle


###### Create runtime image ######
FROM public.ecr.aws/lambda/provided:al2 as runtime

RUN yum install -y oniguruma-devel

# Layer 1: PHP Binaries
COPY --from=builder /var/lang /var/lang

COPY php.ini /var/lang/lib/php.ini

# Layer 2: Runtime Interface Client
# Prepare runtime files
COPY runtime/bootstrap /var/runtime
RUN chmod 0755 /var/runtime/bootstrap

# Layer 3: Vendor
COPY --from=builder /lambda-php-vendor/vendor /opt/vendor

# You chose your lambda function
# to copy inside the container
COPY src/ /var/task/

RUN /var/lang/bin/php -v

CMD [ "index" ]