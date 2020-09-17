FROM openjdk:8u252-slim

ARG STARGATE_VERSION=v0.0.5
ARG PERSISTENCE_VERSION=v0.0.1

RUN apt update && apt install curl unzip iproute2 libaio1 -y

RUN curl -sL https://github.com/stargate/stargate/releases/download/${STARGATE_VERSION}/stargate-jars.zip > stargate-jars.zip
RUN curl -sL https://github.com/stargate/persistence-extensions/releases/download/${PERSISTENCE_VERSION}/stargate-jars.zip > persistence-jars.zip

RUN unzip -n stargate-jars && unzip -n persistence-jars 'stargate-lib/persistence-dse*' # Both will unzip directly into the existing stargate-lib directory

RUN chmod +x starctl
ENTRYPOINT ["./starctl"]