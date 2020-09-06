#!/bin/sh


export ADMIN_POD =$(kubectl get pod -l app=ubuntu -o jsonpath='{.items[0].metadata.name}')
echo "ADMIN_POD: $ADMIN_POD"

sh -c "kubectl exec -i $(ADMIN_POD) -- bash -c $*"

