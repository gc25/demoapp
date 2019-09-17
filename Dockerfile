FROM pradyroy/alpine-openjdk-12.0.2:1.0
VOLUME /tmp /var/applogs
ARG DEPENDENCY=target/dependency
COPY ${DEPENDENCY}/BOOT-INF/lib/ app/lib
COPY ${DEPENDENCY}/META-INF /app/META-INF
COPY ${DEPENDENCY}/BOOT-INF/classes /app
EXPOSE 8080
ENTRYPOINT java -cp app:app/lib/* in.pune.pradyroy.DemoApp > /var/applogs/app.log 2>&1
