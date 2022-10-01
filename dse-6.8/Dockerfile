FROM openjdk:8-slim

RUN set -x \
    && groupadd -r stargate --gid=999 \
    && useradd -r -g stargate -d /stargate --uid=999 stargate

ARG STARGATE_VERSION=v1.0.66

RUN apt update -qq \
    && apt install curl unzip iproute2 libaio1 -y \
    && apt autoremove --yes \
    && apt clean all \
    && rm -rf /var/lib/apt/lists/*

USER stargate
WORKDIR /stargate

RUN curl -sL https://github.com/stargate/stargate/releases/download/${STARGATE_VERSION}/stargate-jars.zip > stargate-jars.zip \
    && unzip stargate-jars -x "*/persistence-*" \
    && unzip stargate-jars "*/persistence-api*" \
    && unzip stargate-jars "*/persistence-dse-6.8*" \
    && rm stargate-jars.zip

RUN chmod +x starctl
ENTRYPOINT ["./starctl"]
