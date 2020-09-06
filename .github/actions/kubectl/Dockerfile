# eks version
FROM alpine/k8s:1.16.8

LABEL maintainer="Rokhun Jung <j.rokhun@gmail.com>"

RUN apk add --update \
        coreutils \
        py-pip

RUN pip install awscli


aws configure set aws_access_key_id ${aws_access_key_id}
aws configure set aws_secret_access_key ${aws_secret_access_key}
aws configure set region ${aws_region}

# Extract the base64 encoded config data and write this to the KUBECONFIG
echo "$KUBE_CONFIG_DATA" | base64 --decode > $HOME/.kube/config/kube_config_cluster.yaml
# export KUBECONFIG=/tmp/config



COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]