
FROM alpine:latest


LABEL maintainer="Miguel Lemos <miguelemosreverte@gmail.com>"


ADD https://storage.googleapis.com/kubernetes-release/release/v1.11.1/bin/linux/amd64/kubectl /usr/local/bin/kubectl
ADD https://github.com/kubernetes-sigs/aws-iam-authenticator/releases/download/v0.3.0/heptio-authenticator-aws_0.3.0_linux_amd64 /usr/local/bin/aws-iam-authenticator

RUN set -x && \
    \
    apk add --update --no-cache curl ca-certificates python py-pip jq && \
    \
    # Install AWS CLI
    pip install --upgrade awscli && \
    # Basic check it works.
    aws --version && kubectl version --client

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]