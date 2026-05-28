FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    openssh-server \
    sudo \
    curl \
    wget \
    nano \
    tmux \
    htop \
    neofetch

RUN mkdir /var/run/sshd

# password root
RUN echo 'root:root123' | chpasswd

# konfigurasi ssh
RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
RUN echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config

EXPOSE 2222

CMD ["/usr/sbin/sshd","-D","-p","2222"]
