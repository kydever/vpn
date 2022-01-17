FROM alpine:3.15

LABEL maintainer="limx <l@hyperf.io>" version="1.0" license="MIT" app.name="ssh-server"

RUN apk add --update --no-cache openssh \
    && passwd -d root

COPY ./entrypoint.sh /

EXPOSE 22

ENTRYPOINT ["/entrypoint.sh"]
