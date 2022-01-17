FROM alpine:3.15

LABEL maintainer="limx <l@hyperf.io>" version="1.0" license="MIT" app.name="ssh-server"

RUN apk add --update --no-cache openssh tzdata \
    && passwd -d root \
    && ssh-keygen -A \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && sed -i "s/#PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config \
    && ssh-keygen -t dsa -P "" -f /etc/ssh/ssh_host_dsa_key \
    && ssh-keygen -t rsa -P "" -f /etc/ssh/ssh_host_rsa_key \
    && ssh-keygen -t ecdsa -P "" -f /etc/ssh/ssh_host_ecdsa_key \
    && ssh-keygen -t ed25519 -P "" -f /etc/ssh/ssh_host_ed25519_key

COPY ./entrypoint.sh /
COPY ./authorized_keys /root/.ssh/authorized_keys

EXPOSE 22

ENTRYPOINT ["/usr/sbin/sshd", "-D"]
