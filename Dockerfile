FROM alpine:latest

RUN apk update
RUN apk add ansible
RUN apk add python3-dev py3-pip

RUN mkdir -p /root/.ssh && \
    chmod 0700 /root/.ssh

CMD ["ansible", "--version"]
