FROM dtfuller/stretch-slim:0.11

RUN mkdir -p /usr/share/man/man1 && \
		apt-get update && \ 
		apt-get install -y openjdk-8-jre openjdk-8-jre-headless openjdk-8-jdk wget

# WORKDIR /usr/local/share/
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/

