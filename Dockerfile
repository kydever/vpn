FROM alpine:3.15

LABEL maintainer="limx <l@hyperf.io>" version="1.0" license="MIT" app.name="ssh-server"

ARG ROOT_PASSWORD

RUN apk add --update --no-cache openssh tzdata \
    && passwd -d root \
    && ssh-keygen -A \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && sed -i "s/#PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config \
    && echo "root:${ROOT_PASSWORD:-'root'}" | chpasswd

COPY ./authorized_keys /root/.ssh/authorized_keys

EXPOSE 22

ENTRYPOINT ["/usr/sbin/sshd", "-D"]
