FROM debian:stretch-slim 
USER root
ENV SSH_TTY=1

# install base common utilities. 
RUN apt-get update && apt-get install -y apt-utils vim git man
RUN git clone https://github.com/dtfuller/configs.git /usr/local/etc/configs.git
RUN ln -s /usr/local/etc/configs.git/dotfiles/.vimrc /etc/vim/vimrc.local 
RUN ln -rs /usr/local/etc/configs.git/dotfiles/.vim/* /etc/vim/
RUN echo "\nif [ -e /usr/local/etc/configs.git/dotfiles/.bashrc ]; then \
          \n    source /usr/local/etc/configs.git/dotfiles/.bashrc \
          \nfi" >> /etc/bash.bashrc; 
RUN echo "\nif [ -e /usr/local/etc/configs.git/dotfiles/.bash_profile ]; then \
          \n    source /usr/local/etc/configs.git/dotfiles/.bash_profile \
          \nfi" >> /etc/pro+file; 

ADD ./keepbusy /usr/local/bin

RUN rm /etc/skel/.bashrc /etc/skel/.profile
RUN ln -s /usr/local/etc/configs.git/dotfiles/.bashrc /etc/skel/.bashrc
RUN ln -s /usr/local/etc/configs.git/dotfiles/.bash_profile /etc/skel/.bash_profile

RUN mkdir -p /docker-entrypoint.d
COPY ./docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
