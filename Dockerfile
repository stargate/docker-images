FROM openjdk:8u252-slim

RUN apt update -qq \
    && apt install curl unzip iproute2 libaio1 -y \
    && apt autoremove --yes \
    && apt clean all \
    && rm -rf /var/lib/apt/lists/*