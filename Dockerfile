FROM ubuntu:22.04

RUN apt-get update && apt-get install -y sudo
RUN useradd -ms /bin/bash kapilgain
RUN usermod -aG sudo kapilgain
RUN echo 'kapilgain ALL=(ALL) NOPASSWD: ALL' | sudo tee -a /etc/sudoers

USER kapilgain
WORKDIR /home/kapilgain
COPY setup.sh setup.sh
COPY local.yml local.yml

CMD ["/home/kapilgain/setup.sh", "-t", "local.yml"]
