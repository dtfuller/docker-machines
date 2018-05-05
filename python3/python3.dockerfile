FROM dtfuller/stretch-slim:0.1

USER root
RUN apt-get update && apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
xz-utils tk-dev

RUN /bin/bash -c " useradd -m python" 

USER python
WORKDIR /home/python/
RUN curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash 

USER root 
RUN echo 'export PATH="/home/python/.pyenv/bin:$PATH" \
\neval "$(pyenv init -)" \
\neval "$(pyenv virtualenv-init -)"' > /etc/profile.d/.pyenv
RUN echo '\n\n\n. /etc/profile.d/.pyenv' >> .bash_profile

USER python
RUN /bin/bash -c ". .bash_profile && \
                    pyenv update && \
                    pyenv install 3.6.0 && \
                    pyenv global 3.6.0 && \
                    mkdir -p /home/python/src"

ENTRYPOINT ["keepbusy"]
