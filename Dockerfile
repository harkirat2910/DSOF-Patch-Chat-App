FROM openjdk:23-ea-2-jdk-oracle
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} app.jar
ENTRYPOINT ["java","-jar","/app.jar"]
RUN apt-get update \
    && apt-get install -y ca-certificates wget bash \
    && apt-get -qy install perl

# Remove current openssl               
RUN apt-get -y remove openssl

# This is required to run “tar” command
RUN apt-get -qy install gcc 

RUN apt-get -q update && apt-get -qy install wget make \
    && wget https://www.openssl.org/source/openssl-1.1.1v.tar.gz \
    && tar -xzvf openssl-1.1.1v.tar.gz \
    && cd openssl-1.1.1v.tar.gz \
    && ./config \
    && make install

