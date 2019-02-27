FROM dtfuller/jdk8:0.1

WORKDIR /usr/local/share/
RUN wget http://www-eu.apache.org/dist/maven/maven-3/3.5.4/binaries/apache-maven-3.5.4-bin.tar.gz \
		&& tar xfv ./apache-maven-3.5.4-bin.tar.gz \
		&& rm apache-maven-3.5.4-bin.tar.gz

ENV PATH /usr/local/share/apache-maven-3.5.4/bin:${PATH}

