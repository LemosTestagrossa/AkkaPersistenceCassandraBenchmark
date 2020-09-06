#!/bin/sh


aws eks update-kubeconfig


# confirm it worked by listing your pods
kubectl get pods --all-namespaces

# or list your helm deployments
helm ls --all-namespaces


kubectl get all

sh -c "$*"
