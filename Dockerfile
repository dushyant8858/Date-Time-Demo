#FROM maven:3.6.3-openjdk-11 as builder
FROM maven:3.6.3-openjdk-8 as builder

COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package

FROM openjdk:8-jdk-alpine as production
#FROM openjdk:11-jre-slim

ARG server_port=8083
ARG rest_hostname=localhost
ARG rest_port=8084

ENV SERVER_PORT=${server_port}
ENV REST_HOSTNAME=${rest_hostname}
ENV REST_PORT=${rest_port}

COPY --from=builder /home/app/target/demo-0.0.1-SNAPSHOT.jar /usr/local/lib/datetime-demo.jar
EXPOSE 8083
ENTRYPOINT java -Dsome.prop=MyAppIsPassed -Dserver.port=${SERVER_PORT} -Drest.hostname=${REST_HOSTNAME} -Drest.port=${REST_PORT} -jar /usr/local/lib/datetime-demo.jar

# docker build -t datetime:latest --build-arg server_port=8083 --build-arg rest_hostname=greeting --build-arg rest_port=8084 --no-cache .
# docker rm datetime && docker run -itd --network=java-mvn -p 8084:8084 --name datetime datetime
# docker tag datetime:latest 275903738462.dkr.ecr.us-east-1.amazonaws.com/datetime:latest
# docker push 275903738462.dkr.ecr.us-east-1.amazonaws.com/datetime:latest

# aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 275903738462.dkr.ecr.us-east-1.amazonaws.com/pt-portal


# # ---------- DD ---------- #
# docker build -t datetime:latest --build-arg server_port=8083 --build-arg rest_hostname=greeting --build-arg rest_port=8084 --no-cache .
# docker stop datetime && docker rm datetime 
# docker run -itd -p 8083:8083 --name datetime datetime
# curl localhost:8083/currentdatetime
