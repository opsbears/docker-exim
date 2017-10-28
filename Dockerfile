FROM opsbears/base:stable

ARG PACKAGEVERSION=4.86.2-2ubuntu2.2

RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update -y \
    && apt-get install -y exim4-daemon-heavy=$PACKAGEVERSION netcat-openbsd
COPY etc /etc
COPY init.sh /init.sh
CMD ["/init.sh"]
EXPOSE 25
HEALTHCHECK --interval=5s --timeout=5s --start-period=120s CMD echo -n "" | nc -q 1 127.0.0.1 25
