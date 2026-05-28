FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Jakarta

# update system
RUN apt update && apt upgrade -y

# install packages utama
RUN apt install -y \
    openssh-server \
    sudo \
    curl \
    wget \
    git \
    nano \
    vim \
    tmux \
    htop \
    neofetch \
    unzip \
    zip \
    tar \
    net-tools \
    iputils-ping \
    dnsutils \
    software-properties-common \
    build-essential \
    python3 \
    python3-pip \
    golang \
    nodejs \
    npm

# ssh setup
RUN mkdir /var/run/sshd

RUN echo 'root:root123' | chpasswd

RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
RUN echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
RUN echo "ClientAliveInterval 60" >> /etc/ssh/sshd_config
RUN echo "ClientAliveCountMax 999" >> /etc/ssh/sshd_config

# install pm2
RUN npm install -g pm2

# install fastfetch
RUN add-apt-repository ppa:zhangsongcui3371/fastfetch -y && \
    apt update && \
    apt install -y fastfetch

# nice banner
RUN echo 'fastfetch' >> /root/.bashrc

EXPOSE 2222

CMD ["/usr/sbin/sshd","-D","-e","-p","2222"]
