FROM dtfuller/stretch-slim:0.1
USER root
SHELL ["/bin/bash", "-c"]

RUN apt-get update && apt-get install -y wget gcc autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev

# get and setup rbenv
RUN git clone https://github.com/rbenv/rbenv.git /usr/local/share/rbenv
RUN echo '# rbenv setup' > /etc/profile.d/rbenv.sh
RUN echo 'export RBENV_ROOT=/usr/local/share/rbenv' >> /etc/profile.d/rbenv.sh
RUN echo 'export PATH="$RBENV_ROOT/bin:$PATH"' >> /etc/profile.d/rbenv.sh
RUN echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh
RUN chmod +x /etc/profile.d/rbenv.sh 
RUN echo $'\. /etc/profile.d/rbenv.sh' >> /usr/local/etc/configs.git/dotfiles/.bash_profile
RUN mkdir -p /usr/local/share/rbenv/{shims,versions,plugins}
RUN cd /usr/local/share/rbenv/ && src/configure && make -C src
RUN git clone https://github.com/rbenv/ruby-build.git /usr/local/share/rbenv/plugins/ruby-build
RUN chmod -R ugo+rwx /usr/local/share/rbenv

# setup working environment. 
RUN useradd -m web
USER web
WORKDIR /home/web

# build & install ruby
RUN /bin/bash -c ". /etc/profile.d/rbenv.sh \ 
                    && rbenv install 2.5.0 \
                    && rbenv global 2.5.0" 

EXPOSE 3000
ENTRYPOINT ["keepbusy"] # start containers in "server mode".
