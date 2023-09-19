echo "core download..."
./var/wp-cli.phar core download --path=/var/www/wordpress --allow-root
echo "waiting for mariadb to be ready..."
sleep 5 # wait for mariadb to be ready

echo "config create..."
./var/wp-cli.phar config create    --allow-root \
            --dbname=$SQL_DATABASE \
            --dbuser=$SQL_USER \
            --dbpass=$SQL_PASSWORD \
            --dbhost=mariadb:3306 --path='/var/www/wordpress'

echo "core install..."
/var/wp-cli.phar core install   --title=$WP_TITLE \
                                --url=$WP_URL \
                                --admin_user=$WP_ADMIN_USER \
                                --admin_email=$WP_ADMIN_EMAIL \
                                --skip-email

/var/wp-cli.phar user create $WP_USER $WP_EMAIL \
                             --path=$WP_PATH


mkdir -p /run/php
/usr/sbin/php-fpm7.3 -F # -F = stay in foreground mode (don't daemonize)
