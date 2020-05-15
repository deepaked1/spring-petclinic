FROM maven:3.6.0-jdk-8-slim AS build-stage
COPY . /project
# COPY /workspace/target /project
WORKDIR /project
#RUN mvn clean package -Dmaven.test.skip=true
RUN ls -al


FROM openjdk:8-jre-alpine
ARG DOCKERIZE_VERSION
RUN ls -al
RUN wget -O dockerize.tar.gz https://github.com/jwilder/dockerize/releases/download/${DOCKERIZE_VERSION}/dockerize-alpine-linux-amd64-${DOCKERIZE_VERSION}.tar.gz 
# RUN wget -O dockerize.tar.gz https://github.com/jwilder/dockerize/releases/download/v0.6.1/dockerize-alpine-linux-amd64-v0.6.1.tar.gz && \
RUN    tar xzf dockerize.tar.gz 
RUN    chmod +x dockerize

FROM scratch
ARG ARTIFACT_NAME
# COPY --from=build-stage /project/${ARTIFACT_NAME}.jar /app.jar
COPY ${ARTIFACT_NAME}.jar /app.jar

ARG EXPOSED_PORT
EXPOSE ${EXPOSED_PORT}

ENV SPRING_PROFILES_ACTIVE docker

ENTRYPOINT ["java", "-XX:+UnlockExperimentalVMOptions", "-XX:+UseCGroupMemoryLimitForHeap", "-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]