service mysql start;

if [ -z "$SQL_ROOT_PASSWORD" ]; then
  echo "SQL_ROOT_PASSWORD is empty"
  exit 1
fi

mysql -u root -p$SQL_ROOT_PASSWORD -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
mysql -u root -p$SQL_ROOT_PASSWORD -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -u root -p$SQL_ROOT_PASSWORD -e "SELECT user, host FROM mysql.user;"
mysql -u root -p$SQL_ROOT_PASSWORD -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -u root -p$SQL_ROOT_PASSWORD -e "ALTER USER 'root'@'localhost' IDENTIFIED BY 'root';FLUSH PRIVILEGES;"

sleep 1
#echo ------------------------------
echo database and user created
#echo ------------------------------
echo shutting down mysql...
#shutdown mysql
mysqladmin -u root -proot shutdown

#echo ------------------------------
echo mysql shut down
#echo ------------------------------
echo restarting mysql...

# restart mysql
exec mysqld_safe
