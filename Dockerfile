FROM alpine:latest

RUN apk update
RUN apk add ansible
RUN apk add python3-dev py3-pip
RUN apk add openssh

ARG UNAME=pi
ARG UID=1000
ARG GID=1000
RUN addgroup -g $GID $UNAME
RUN adduser -u $UID -G $UNAME -h /home/$UNAME -D $UNAME

USER $UNAME

RUN mkdir -p /home/$UNAME/.ssh && \
    chmod 0700 /home/$UNAME/.ssh

CMD ["ansible", "--version"]
