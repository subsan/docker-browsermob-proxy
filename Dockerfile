FROM maven:3.3-jdk-8 AS build
RUN apt-get install unzip
RUN git clone https://github.com/lightbody/browsermob-proxy.git
WORKDIR /browsermob-proxy
RUN mvn -DskipTests
RUN unzip /browsermob-proxy/browsermob-dist/target/browsermob-proxy-2.1.6-SNAPSHOT-bin.zip -d /

FROM openjdk:8
COPY --from=build /browsermob-proxy-2.1.6-SNAPSHOT /browsermob-proxy
EXPOSE 8080-8581
ENTRYPOINT /browsermob-proxy/bin/browsermob-proxy
