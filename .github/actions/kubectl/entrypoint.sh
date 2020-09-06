#!/bin/sh


export ADMIN_POD_NAME=$(kubectl get pod -l app=ubuntu -o jsonpath='{.items[0].metadata.name}')
echo "ADMIN_POD_NAME: $ADMIN_POD"

sh -c "kubectl exec -i $(ADMIN_POD_NAME) -- bash -c $*"

