FROM dtfuller/python3:0.11
USER root
RUN apt-get update && apt-get install -y locales

RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen 
RUN locale-gen

USER python
WORKDIR /home/python/
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
RUN /usr/local/share/pyenv/shims/pip install --upgrade pip \ 
        && /usr/local/share/pyenv/shims/pip install flask
ENTRYPOINT ["keepbusy"]


