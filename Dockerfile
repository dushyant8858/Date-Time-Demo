#FROM maven:3.6.3-openjdk-11 as builder
FROM maven:3.6.3-openjdk-8 as builder

# RUN COPY ADD create layers
COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package

FROM openjdk:8-jdk-alpine as production
#FROM openjdk:11-jre-slim

# ARG can be set during docker build, eg:
# docker build -t datetime:latest --build-arg REST_HOSTNAME=greeting  --build-arg REST_PORT=8082 .
# If receiving from Gitlab/Github, use ${variablename}
# docker build -t datetime:latest --build-arg REST_HOSTNAME=${REST_HOSTNAME}  --build-arg REST_PORT=${REST_PORT} .
# Leave empty as ARG REST_HOSTNAME=
# or with an overridable default as ARG REST_HOSTNAME=localhost
ARG server_port=8083
ARG rest_hostname=localhost
ARG rest_port=8082

# ENV can be set from ARGs
ENV SERVER_PORT=${server_port}
ENV REST_HOSTNAME=${rest_hostname}
ENV REST_PORT=${rest_port}

COPY --from=builder /home/app/target/demo-0.0.1-SNAPSHOT.jar /usr/local/lib/datetime-demo.jar
EXPOSE 8083
# ENTRYPOINT works
#ENTRYPOINT ["java", "-jar", "/usr/local/lib/datetime-demo.jar"]

# Error: Could not find or load main class .usr.local.lib.datetime-demo.jar
# ENTRYPOINT ["java", "-Dserver.port=${SERVER_PORT} -Drest.hostname=${REST_HOSTNAME} -Drest.port=${REST_PORT} -jar", "/usr/local/lib/datetime-demo.jar"]

# Error: Could not find or load main class server.port=${SERVER_PORT} rest.hostname=${REST_HOSTNAME} rest.port=${REST_PORT} -jar
# ENTRYPOINT ["java", "server.port=${SERVER_PORT} rest.hostname=${REST_HOSTNAME} rest.port=${REST_PORT} -jar", "/usr/local/lib/datetime-demo.jar"]

#================== MyApp==================
#================== ==================
#================== ==================
#ENTRYPOINT java -Dserver.port=${SERVER_PORT} -Drest.hostname=${REST_HOSTNAME} -Drest.port=${REST_PORT} -jar /usr/local/lib/datetime-demo.jar

#================== MyAppIsPassed==================
#================== greeting3==================
#================== 80823==================
ENTRYPOINT java -Dsome.prop=MyAppIsPassed -Dserver.port=${SERVER_PORT} -Drest.hostname=${REST_HOSTNAME} -Drest.port=${REST_PORT} -jar /usr/local/lib/datetime-demo.jar
