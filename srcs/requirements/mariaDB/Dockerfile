FROM debian:buster

RUN apt update -y && apt upgrade -y
RUN apt install mariadb-server -y
RUN rm -rf /var/lib/apt/lists/*

# copie du fichier de configuration de la base de données
COPY conf/50-server.cnf    /etc/mysql/mariadb.conf.d/50-server.cnf

# copie du script de création de la base de données
COPY tools/sql_script.sh    /var/sql_script.sh

# port de connexion (par defaut de mariaDB) à la base de données
EXPOSE 3306

CMD ["bash", "/var/sql_script.sh"]
#CMD ["bash"]
