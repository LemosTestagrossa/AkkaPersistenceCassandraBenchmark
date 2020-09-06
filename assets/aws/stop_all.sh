
kubectl delete -f assets/k8s/infra/kafka.yml
kubectl delete -f assets/k8s/infra/cassandra.yml


kubectl delete -f assets/k8s/pcs/pcs-rbac.yml
envsubst < assets/k8s/pcs/pcs-deployment.yml | kubectl delete -f -
kubectl delete -f assets/k8s/pcs/pcs-service.yml
kubectl delete -f assets/k8s/pcs/pcs-service-monitor.yml


helm uninstall prometheus



  portForward:
    name: curl http://0.0.0.0:8081/api/system/status
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - name: port forward
      with:
        kubeconfig-data: ${{ secrets.KUBE_CONFIG_DATA }}
        targetRef:  pcs-7ff9fd66bd-9dps8
        port: 8081

  curl:
    runs-on: ubuntu-latest
    steps:
    - name: curl
      uses: wei/curl@master
      with:
        args: http://0.0.0.0:8081/api/system/status


  deploy:
    name: Deploy to cluster
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - name: deploy to cluster
      uses: qazz92/kubectl@1.0.3
      env:
        kube_confg_data: ${{ secrets.KUBE_CONFIG_DATA }}
        aws_access_key_id: ${{ secrets.AWS_ACCESS_KEY_ID }}
        aws_secret_access_key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
        aws_region: ${{ secrets.AWS_DEFAULT_REGION }}
      with:
        args: get all




  tryKubernetes:
    name: tryKubernetes
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - name: tryKubernetes
      uses: wahyd4/kubectl-helm-action@master
      env:
        KUBE_CONFIG_DATA: ${{ secrets.KUBE_CONFIG_DATA }}
      with:
        args: kubectl get pods