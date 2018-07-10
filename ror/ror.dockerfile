FROM dtfuller/stretch-slim:0.1
USER root
SHELL ["/bin/bash", "-c"]

RUN apt-get update && apt-get install -y wget gcc autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev libpq-dev

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

# nvm env config/requirement
RUN echo $'export NVM_DIR="$HOME/.nvm" \n [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm \n [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion ' >> /usr/local/etc/configs.git/dotfiles/.bash_profile 

# setup working environment. 
RUN useradd -m web
RUN chown -R web:web /usr/local/share/rbenv
USER web
RUN mkdir /home/web/src
WORKDIR /home/web/src

# install nvm, npm and node
RUN mkdir ~/.nvm && wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
RUN /bin/bash -c ". /home/web/.bash_profile && nvm install v8.11.1";

# build & install ruby
RUN /bin/bash -c ". /etc/profile.d/rbenv.sh \ 
                    && rbenv install 2.5.0 \
                    && rbenv global 2.5.0" 

# install bundle and rails gems
RUN /bin/bash -c ". /etc/profile.d/rbenv.sh \
                    && gem install bundle \ 
                    && gem install rails -v 5.1.5" 

EXPOSE 3000
ENTRYPOINT ["/bin/bash", "-c", ". ~/.bash_profile && . /etc/profile.d/rbenv.sh && bundle install && . /etc/profile.d/rbenv.sh && rails server"]
