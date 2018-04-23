FROM debian:stretch-slim 
USER root

# to-do: aún no se logran  mostrar los colores ni configuraciones extras que se le están haciendo a bash

# install base common utilities. 
RUN apt-get update && apt-get install -y apt-utils vim git 
RUN git clone https://github.com/dtfuller/configs.git /usr/local/etc/configs.git
RUN ln -s /usr/local/etc/configs.git/dotfiles/.vimrc /etc/vim/vimrc.local 
RUN ln -rs /usr/local/etc/configs.git/dotfiles/.vim/* /etc/vim/
RUN echo "\nif [ -e /usr/local/etc/configs.git/dotfiles/.bashrc ]; then \
          \n    source /usr/local/etc/configs.git/dotfiles/.bashrc \
          \nfi" >> /etc/bash.bashrc; 
RUN echo "\nif [ -e /usr/local/etc/configs.git/dotfiles/.bash_profile ]; then \
          \n    source /usr/local/etc/configs.git/dotfiles/.bash_profile \
          \nfi" >> /etc/profile; 
