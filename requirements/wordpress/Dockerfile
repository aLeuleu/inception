FROM debian:buster

RUN apt update -y \
    && apt upgrade -y \
    && apt install -y wget

RUN apt-get install -y php7.3\
						php-fpm\
						php-mysql\
						mariadb-client

#php-fpm aims to solve t.he problem of executing PHP \
#scripts under different user accounts.
#It creates and listens on a socket,
#and sets the user of the current process to the owner of the script that is executed. \
#This allows you to run PHP scripts as a different user than the web server.
#fpm stands for FastCGI Process Manager.

#ce fichier de conf est quasi identique a celui de base
#on a simplement
COPY www.conf /etc/php/7.3/fpm/pool.d/www.conf

#on installe wp-cli pour pouvoir editer facilement le fichier de conf de wp
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /var/

# on copie et on lance le script qui va configurer wp-cli
COPY wp_install.sh /wp_install.sh
RUN chmod +x /wp_install.sh

#on lance le script qui va configurer wp-cli
CMD ["bash", "/wp_install.sh"]

EXPOSE 9000