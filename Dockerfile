FROM --platform=$BUILDPLATFORM openjdk:22-slim-bullseye as builder

WORKDIR /opt/app

RUN apt-get update && apt-get install ca-certificates -y && update-ca-certificates 


COPY mvnw .
COPY .mvn .mvn 

COPY pom.xml .

COPY src src
RUN ./mvnw clean package -DskipTests


FROM  openjdk:22-slim-bullseye

RUN apt-get update && apt-get install ca-certificates -y && update-ca-certificates

ENV PYROSCOPE_APPLICATION_NAME=demo-app
ENV PYROSCOPE_FORMAT=jfr
ENV PYROSCOPE_PROFILING_INTERVAL=10ms
ENV PYROSCOPE_PROFILER_EVENT=itimer
ENV PYROSCOPE_PROFILER_LOCK=10ms
ENV PYROSCOPE_PROFILER_ALLOC=512k
ENV PYROSCOPE_UPLOAD_INTERVAL=15s
ENV PYROSCOPE_LOG_LEVEL=debug
ENV PYROSCOPE_SERVER_ADDRESS=http://pyroscope:4040

COPY --from=builder /opt/app/target/pyroscope-demo-0.0.1-SNAPSHOT.jar /opt/app/target/pyroscope-demo-0.0.1-SNAPSHOT.jar

WORKDIR /opt/app

ADD https://github.com/grafana/pyroscope-java/releases/download/v0.14.0/pyroscope.jar /opt/app/pyroscope.jar

CMD sh -c "exec java -javaagent:pyroscope.jar -jar ./target/pyroscope-demo-0.0.1-SNAPSHOT.jar"
