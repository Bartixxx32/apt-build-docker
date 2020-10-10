FROM ubuntu:20.04 AS BUILD_IMAGE
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update
RUN apt install wget -y
RUN wget https://gist.githubusercontent.com/ishad0w/788555191c7037e249a439542c53e170/raw/3822ba49241e6fd851ca1c1cbcc4d7e87382f484/sources.list -O /etc/apt/sources.list
FROM ubuntu:20.04
ARG DEBIAN_FRONTEND=noninteractive
COPY --from=BUILD_IMAGE /etc/apt/sources.list  /etc/apt/sources.list
RUN apt update
RUN apt-get -qq install apt-build
RUN apt-build update
RUN apt-build upgrade -y
COPY build.sh .
RUN chmod +x build.sh
ENTRYPOINT ["bash", "build.sh"]