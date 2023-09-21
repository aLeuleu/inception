FROM debian:buster

ARG WP_PATH
ARG WP_URL

RUN apt update
RUN apt upgrade -y
RUN apt install -y nginx
RUN apt install -y openssl
RUN apt install -y gettext
RUN rm -rf /var/lib/apt/lists/*
RUN mkdir -p /etc/nginx/ssl # pour stocker le certificat ssl et la clef privée

# -x509: certificate type
# -nodes: disable password
# -out: certificate file
# -keyout: key certificate file
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt -subj "/C=FR/ST=Paris/L=Paris/O=42/OU=42Paris/CN=ft_server"

COPY conf/nginx.conf /etc/nginx/nginx.conf.template
RUN export WP_PATH=$WP_PATH WP_URL=$WP_URL && \
    envsubst < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf

CMD ["nginx", "-g", "daemon off;"]

EXPOSE 443
