#!/bin/sh

set -xe

sh -c "aws configure set aws_access_key_id ${aws_access_key_id}"
sh -c "aws configure set aws_secret_access_key ${aws_secret_access_key}"
sh -c "aws configure set region ${aws_region}"

# Extract the base64 encoded config data and write this to the KUBECONFIG

# Write a ~/.kube/config file, using the AWS CLI to fetch the necessary parameters
mkdir -p ~/.kube
echo "$KUBE_CONFIG_DATA" | base64 --decode > ~/.kube/config

# export KUBECONFIG=/tmp/config

kubectl get all

sh -c "$*"
