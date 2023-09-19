FROM debian:buster

RUN apt update
RUN apt upgrade -y
RUN apt install -y nginx
RUN apt install -y openssl
RUN mkdir -p /etc/nginx/ssl # pour stocker le certificat ssl et la clef privée

# -x509: certificate type
# -nodes: disable password
# -out: certificate file
# -keyout: key certificate file
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt -subj "/C=FR/ST=Paris/L=Paris/O=42/OU=42Paris/CN=ft_server"

COPY nginx.conf /etc/nginx

CMD ["nginx", "-g", "daemon off;"]


