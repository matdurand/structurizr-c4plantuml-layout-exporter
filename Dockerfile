FROM gradle:jdk17-alpine as build

COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
RUN gradle shadowJar --no-daemon

FROM eclipse-temurin:17.0.5_8-jre-jammy
RUN mkdir /app
COPY --from=build /home/gradle/src/build/libs/*.jar /app/struct-c4-layout.jar

## Install PlantUML
RUN apt-get update
RUN apt install -y graphviz
RUN curl https://versaweb.dl.sourceforge.net/project/plantuml/plantuml.jar --output /app/plantuml.jar
COPY ./docker/exporter.sh /app/exporter.sh

ENTRYPOINT ["/app/exporter.sh"]