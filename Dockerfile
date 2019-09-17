FROM pradyroy/alpine-openjdk-12.0.2:1.0
VOLUME /tmp /var/applogs
ARG DEPENDENCY=target/dependency
EXPOSE 8080
