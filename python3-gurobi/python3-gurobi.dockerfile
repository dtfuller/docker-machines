FROM dtfuller/python3:0.11

# setup environment and get installation assets.
USER root
WORKDIR /usr/local/share
RUN wget http://packages.gurobi.com/8.0/gurobi8.0.0_linux64.tar.gz
RUN tar xf ./gurobi8.0.0_linux64.tar.gz

# install gurobi python
RUN chown -R python:python /usr/local/share/gurobi800
USER python
WORKDIR /usr/local/share/gurobi800/linux64
RUN /bin/bash -c ". ~/.bash_profile && \ 
                   $(pyenv which python3) ./setup.py install"

USER root

RUN echo '\n\n \
export GUROBI_HOME="/usr/local/share/gurobi800/linux64/"   \n\
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH":$GUROBI_HOME/lib \n\
export PATH="$PATH":$GUROBI_HOME/bin                         \
' >> /etc/profile.d/.pyenv

USER python
ENTRYPOINT ["keepbusy"]
