FROM dtfuller/python3:0.11
USER root
RUN apt-get update && \ 
    apt-get install -y locales make build-essential zlib1g-dev libbz2-dev \
    libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
    xz-utils tk-dev libffi-dev liblzma-dev python-openssl libssl1.0-dev 
    # libssl-dev

RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen 
RUN locale-gen

USER python
WORKDIR /home/python/
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
RUN /usr/local/share/pyenv/shims/pip install --upgrade pip \ 
        && /usr/local/share/pyenv/shims/pip install flask
