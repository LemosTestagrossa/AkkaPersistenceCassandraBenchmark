#!/bin/sh

set -xe

sh -c "aws configure set aws_access_key_id ${aws_access_key_id}"
sh -c "aws configure set aws_secret_access_key ${aws_secret_access_key}"
sh -c "aws configure set region ${aws_region}"

# Extract the base64 encoded config data and write this to the KUBECONFIG
echo "$KUBE_CONFIG_DATA" | base64 --decode > /tmp/config
export KUBECONFIG=/tmp/config


kubectl get all

export ADMIN_POD_NAME=$(kubectl get pod -l app=ubuntu -o jsonpath='{.items[0].metadata.name}')
echo "ADMIN_POD_NAME: $ADMIN_POD"

sh -c "kubectl exec -i $(ADMIN_POD_NAME) -- bash -c $*"

