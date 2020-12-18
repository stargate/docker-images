FROM stargate-builder as builder

ARG STARGATE_VERSION=v1.0.1

RUN curl -L https://github.com/stargate/stargate/releases/download/${STARGATE_VERSION}/stargate-jars.zip > stargate-jars.zip \
    && unzip stargate-jars -x "*/persistence-*" \
    && unzip stargate-jars "*/persistence-api*" \
    && unzip stargate-jars "*/persistence-cassandra-3.11*" \
    && rm stargate-jars.zip

RUN chmod +x starctl
ENTRYPOINT ["./starctl"]
