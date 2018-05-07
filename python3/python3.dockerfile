FROM dtfuller/stretch-slim:0.1
USER root

# install base utilities
RUN apt-get update && apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
xz-utils tk-dev

# get and setup pyenv
WORKDIR /usr/local/share
RUN git clone https://github.com/pyenv/pyenv.git ./pyenv \
    && git clone git://github.com/pyenv/pyenv-update.git ./pyenv/plugins/pyenv-update \
    && git clone https://github.com/pyenv/pyenv-virtualenv.git ./pyenv/plugins/pyenv-virtualenv \
    && git clone git://github.com/yyuu/pyenv-doctor.git ./pyenv/plugins/pyenv-doctor

# setup environment
ENV PYENV_ROOT="/usr/local/share/pyenv"
ENV PATH="$PYENV_ROOT"/bin:$PATH

# setup running user, install and setup python version.
RUN /bin/bash -c " useradd -m python"
RUN chown -R python:python /usr/local/share/pyenv
USER python
WORKDIR /home/python
RUN /bin/bash -c " pyenv update       \
        && pyenv install 3.6.0        \
        && pyenv global 3.6.0         \
        && mkdir -p /home/python/src"

# add bash_profile configuration.
USER root
RUN echo '\n\n \
eval "$(pyenv init -)" \n\
eval "$(pyenv virtualenv-init - )"' > /etc/profile.d/.pyenv
RUN echo '\n. /etc/profile.d/.pyenv' >> /usr/local/etc/configs.git/dotfiles/.bash_profile

# setup run environment.
USER python
ENTRYPOINT ["keepbusy"]
