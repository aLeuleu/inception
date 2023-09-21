if [ ! -f "${WP_PATH}/wp-config.php" ]; then

echo "core download..."
./var/wp-cli.phar core download --path=$WP_PATH --allow-root
echo "waiting for mariadb to be ready..."
sleep 5 # wait for mariadb to be ready

echo "config create..."
./var/wp-cli.phar config create   --allow-root \
                                  --dbname=$SQL_DATABASE \
                                  --dbuser=$SQL_USER \
                                  --dbpass=$SQL_PASSWORD \
                                  --dbhost=mariadb:3306 \
                                  --path=$WP_PATH

echo "core install..."
./var/wp-cli.phar core install   --url="${WP_URL}" \
                  --title="${WP_TITLE}" \
                  --admin_user="${WP_ADMIN_USER}" \
                  --admin_password="${WP_ADMIN_PASSWORD}" \
                  --admin_email="${WP_ADMIN_EMAIL}" \
                  --allow-root \
                  --path=${WP_PATH}

echo "user create..."
/var/wp-cli.phar user create $WP_USER $WP_USER_EMAIL \
                               --allow-root \
                               --path=$WP_PATH
fi
mkdir -p /run/php
/usr/sbin/php-fpm7.3 -F # -F = stay in foreground mode (don't daemonize)
