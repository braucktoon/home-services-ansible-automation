FROM alpine:latest

RUN apk update
RUN apk add ansible
RUN apk add python3-dev py3-pip

CMD ["ansible", "--version"]
