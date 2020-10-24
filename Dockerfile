FROM ubuntu:20.10 AS BUILD_IMAGE
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update -y
RUN apt install wget -y
RUN wget https://gist.githubusercontent.com/Bartixxx32/08f5cc3029f9b05c8b80e6e43bebb436/raw/0cd29718335f128535ee6ccb63e252d9b5b1b1e2/sources.list -O /etc/apt/sources.list
FROM ubuntu:20.10
ARG DEBIAN_FRONTEND=noninteractive
COPY --from=BUILD_IMAGE /etc/apt/sources.list  /etc/apt/sources.list
RUN apt update
RUN apt-get -qq install apt-build
RUN apt-get upgrade -y
COPY build.sh .
RUN chmod +x build.sh
ENTRYPOINT ["bash", "build.sh"]
