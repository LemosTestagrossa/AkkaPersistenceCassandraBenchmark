# eks version
FROM jshimko/kube-tools-aws:latest

LABEL maintainer="Miguel Lemos <miguelemosreverte@gmail.com>"

aws eks update-kubeconfig


# confirm it worked by listing your pods
kubectl get pods --all-namespaces

# or list your helm deployments
helm ls --all-namespaces



COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]