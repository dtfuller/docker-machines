FROM dtfuller/stretch-slim:0.11

RUN mkdir -p /usr/share/man/man1
RUN apt-get update && apt-get install -y  openjdk-8-jre openjdk-8-jre-headless \
		openjdk-8-jdk wget
WORKDIR /usr/local/share/
RUN wget http://www-eu.apache.org/dist/maven/maven-3/3.5.4/binaries/apache-maven-3.5.4-bin.tar.gz \
		&& tar xfv ./apache-maven-3.5.4-bin.tar.gz \
		&& rm apache-maven-3.5.4-bin.tar.gz

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
ENV PATH /usr/local/share/apache-maven-3.5.4/bin:${PATH}
