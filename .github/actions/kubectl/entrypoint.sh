#!/bin/sh

set -xe

sh -c "aws configure set aws_access_key_id ${aws_access_key_id}"
sh -c "aws configure set aws_secret_access_key ${aws_secret_access_key}"
sh -c "aws configure set region ${aws_region}"

# Extract the base64 encoded config data and write this to the KUBECONFIG
echo "$KUBE_CONFIG_DATA" | base64 --decode > /tmp/config
export KUBECONFIG=/tmp/config


if [!  -z "$USE_THE_GITHUB_CI_KUBECTL" ]
then
  sh -c "kubectl $*"
else
  # else, we use the GITHUB_CI_KUBECTL, meaning, the kubectl provided by this docker image,
  # to run commands inside our cluster administration pod.
  # for example, inside our administration pod we can run
  # docker build orders, push to ECR, and it will run faster,
  # because it will run using our t2.x2large instances, with
  # minimal latency against AWS where it is hosted, itself.
  sh -c "kubectl exec -i $(kubectl get pod -l app=ubuntu -o jsonpath='{.items[0].metadata.name}') -- $*"
fi