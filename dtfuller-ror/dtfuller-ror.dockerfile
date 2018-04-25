FROM dtfuller-stretch:latest 
USER root

SHELL ["/bin/bash", "-c"]
RUN apt-get update && apt-get install -y make gcc bzip2 
RUN chmod 777 -R /usr/local/etc/configs.git/
RUN useradd -m web

# setup and install rbenv.
USER web
ADD ./rbenv_bin /home/web/rbenv_bin
RUN cat /home/web/rbenv_bin >> /home/web/.bash_profile
RUN rm /home/web/rbenv_bin
RUN git clone https://github.com/rbenv/rbenv.git ~/.rbenv
RUN cd ~/.rbenv && src/configure && make -C src
RUN mkdir -p "$(/home/web/.rbenv/bin/rbenv root)"/plugins 
RUN git clone https://github.com/rbenv/ruby-build.git "$(/home/web/.rbenv/bin/rbenv root)"/plugins/ruby-build
RUN . ~/.bashrc

# install ruby + ror
RUN /home/web/.rbenv/bin/rbenv install 2.5.0 


ENTRYPOINT ["keepbusy"]
