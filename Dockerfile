FROM openjdk:8-jre-slim-buster

WORKDIR /minecraft

RUN apt-get update \
  && apt-get install -y --no-install-recommends curl unzip\
  && apt-get install nano -y \
  && curl https://tekxit.xyz/downloads/1.0.950TekxitPiServer.zip -o 1.0.8TekxitPiServer.zip \
  && unzip 1.0.8TekxitPiServer.zip \
  && rm 1.0.8TekxitPiServer.zip \
  && chmod +x 1.0.8TekxitPiServer/ServerLinux.sh 

RUN sed -i "s|java -server -Xmx4G -Xms4G -jar forge-1.12.2-14.23.5.2860.jar nogui|#!/bin/bash\njava -server -Xmx4G -Xms4G -Dfml.queryResult=confirm -jar forge-1.12.2-14.23.5.2860.jar nogui |g" 1.0.8TekxitPiServer/ServerLinux.sh

WORKDIR /minecraft/1.0.8TekxitPiServer

RUN sed -i "s|eula=false|eula=true |g" eula.txt


EXPOSE 25565/udp
EXPOSE 25565/tcp

CMD ["./ServerLinux.sh"]