FROM maven:3.6.0-jdk-8-slim AS build-stage
COPY . /project
WORKDIR /project
RUN ls -al
RUN mvn clean package


FROM openjdk:8-jre-alpine
#VOLUME /workspace/source/
# WORKDIR /workspace/source/
# ADD . /workspace/source/

# Download dockerize and cache that layer
# ARG DOCKERIZE_VERSION
#ARG DOCKERIZE_VERSION=v0.6.1
ARG DOCKERIZE_VERSION
RUN echo ${DOCKERIZE_VERSION}
#RUN wget -O dockerize.tar.gz https://github.com/jwilder/dockerize/releases/download/${DOCKERIZE_VERSION}/dockerize-alpine-linux-amd64-${DOCKERIZE_VERSION}.tar.gz
# RUN wget -O dockerize.tar.gz https://github.com/jwilder/dockerize/releases/download/v0.6.1/dockerize-alpine-linux-amd64-${DOCKERIZE_VERSION}.tar.gz
# RUN tar xzf dockerize.tar.gz
# RUN chmod +x dockerize

# FROM scratch
# This is the first layer that won't be cached
# ARG ARTIFACT_NAME
ARG ARTIFACT_NAME=*
ARG ARTIFACT_NAME
#ADD ${ARTIFACT_NAME}.jar /app.jar
#COPY --from=build-stage /workspace/source/ /app/source/
COPY --from=build-stage /project/target/spring-petclinic-2.3.0.BUILD-SNAPSHOT.jar /app.jar

# ARG EXPOSED_PORT
ARG EXPOSED_PORT=8080
ARG EXPOSED_PORT
#EXPOSE ${EXPOSED_PORT}
EXPOSE 8080

ENV SPRING_PROFILES_ACTIVE docker

ENTRYPOINT ["java", "-XX:+UnlockExperimentalVMOptions", "-XX:+UseCGroupMemoryLimitForHeap", "-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]