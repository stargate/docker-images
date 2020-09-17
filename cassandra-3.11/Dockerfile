FROM openjdk:8u252-slim

ARG STARGATE_VERSION=v0.0.5

RUN apt update && apt install curl unzip iproute2 libaio1 -y
RUN curl -L https://github.com/stargate/stargate/releases/download/${STARGATE_VERSION}/stargate-jars.zip > stargate-jars.zip

RUN unzip stargate-jars

RUN chmod +x starctl
ENTRYPOINT ["./starctl"]