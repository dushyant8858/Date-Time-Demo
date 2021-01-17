#FROM maven:3.6.3-openjdk-11 as builder
FROM maven:3.6.3-openjdk-8 as builder

COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package

FROM openjdk:8-jdk-alpine as production
#FROM openjdk:11-jre-slim

ARG server_port=8083
ARG rest_hostname=localhost
ARG rest_port=8082

ENV SERVER_PORT=${server_port}
ENV REST_HOSTNAME=${rest_hostname}
ENV REST_PORT=${rest_port}

COPY --from=builder /home/app/target/demo-0.0.1-SNAPSHOT.jar /usr/local/lib/datetime-demo.jar
EXPOSE 8083ENTRYPOINT java -Dsome.prop=MyAppIsPassed -Dserver.port=${SERVER_PORT} -Drest.hostname=${REST_HOSTNAME} -Drest.port=${REST_PORT} -jar /usr/local/lib/datetime-demo.jar
