FROM debian:buster

RUN apt update
RUN apt upgrade -y
RUN apt install -y nginx

COPY ./config/* /etc/nginx

CMD ["nginx", "-g", "daemon off;"]