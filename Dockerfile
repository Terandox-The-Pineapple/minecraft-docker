ARG JAVA_VERSION=8

FROM openjdk:${JAVA_VERSION} AS JAVA_BASE

RUN useradd -ms /bin/bash minecraft-server

USER minecraft-server

RUN mkdir /home/minecraft-server/server

WORKDIR /home/minecraft-server/server

ENTRYPOINT [ "/home/minecraft-server/entrypoint.sh" ]
CMD [ "run" ]