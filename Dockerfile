##################################################################
# Base Image
##################################################################
FROM ubuntu:22.04

##################################################################
# Build arguments
##################################################################
ARG TIMEZONE=Europe/Istanbul
ARG LOCALE=tr_TR.UTF-8

##################################################################
# Environment variables
##################################################################
ENV LANG=$LOCALE
ENV LANGUAGE=$LOCALE
ENV LC_ALL=$LOCALE
ENV TZ=$TIMEZONE

##################################################################
# System Preparation
##################################################################
RUN apt-get update && apt-get install -y qemu-system-x86 qemu-utils tigervnc-standalone-server && mkdir /machine /iso /root/.vnc

##################################################################
# Box Installation
##################################################################
COPY main.sh /main.sh
RUN chmod +x /main.sh

CMD ["/main.sh"]
