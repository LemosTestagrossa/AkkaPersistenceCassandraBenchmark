

cd AkkaPersistenceCassandraBenchmark

git pull origin master

git commit -m "merge!"


kubectl delete -f assets/k8s/infra/kafka.yml
kubectl delete -f assets/k8s/infra/cassandra.yml


kubectl delete -f assets/k8s/pcs/pcs-rbac.yml
envsubst < assets/k8s/pcs/pcs-deployment.yml | kubectl delete -f -
kubectl delete -f assets/k8s/pcs/pcs-service.yml
kubectl delete -f assets/k8s/pcs/pcs-service-monitor.yml


helm uninstall prometheus


aws ecr get-login-password --region ap-northeast-2 | docker login --username AWS --password-stdin 099925565557.dkr.ecr.ap-northeast-2.amazonaws.com

sbt pcs/docker:publishLocal
# docker tag pcs/pcs:1.0 099925565557.dkr.ecr.us-west-2.amazonaws.com/pcs-akka:latest
docker tag open-source:latest 099925565557.dkr.ecr.ap-northeast-2.amazonaws.com/open-source:latest
docker push 099925565557.dkr.ecr.ap-northeast-2.amazonaws.com/open-source:latest
export IMAGE=099925565557.dkr.ecr.ap-northeast-2.amazonaws.com/open-source:latest

kubectl apply -f assets/k8s/infra/cassandra.yml



curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
helm repo add stable https://kubernetes-charts.storage.googleapis.com
helm install prometheus stable/prometheus-operator --namespace copernico



export pod_name=$(kubectl get pod --selector app=cassandra | grep cassandra | cut -d' ' -f 1)

# call setup_cassandra.sh
kubectl exec -i $pod_name cqlsh < assets/scripts/cassandra/infrastructure/akka/keyspaces/akka.cql

kubectl exec -i $pod_name cqlsh < assets/scripts/cassandra/infrastructure/akka/keyspaces/akka.cql
kubectl exec -i $pod_name cqlsh < assets/scripts/cassandra/infrastructure/akka/keyspaces/akka_snapshot.cql
kubectl exec -i $pod_name cqlsh < assets/scripts/cassandra/infrastructure/akka/tables/all_persistence_ids.cql
kubectl exec -i $pod_name cqlsh < assets/scripts/cassandra/infrastructure/akka/tables/messages.cql
kubectl exec -i $pod_name cqlsh < assets/scripts/cassandra/infrastructure/akka/tables/metadata.cql
kubectl exec -i $pod_name cqlsh < assets/scripts/cassandra/infrastructure/akka/tables/snapshots.cql
kubectl exec -i $pod_name cqlsh < assets/scripts/cassandra/infrastructure/akka/tables/tag_scanning.cql
kubectl exec -i $pod_name cqlsh < assets/scripts/cassandra/infrastructure/akka/tables/tag_views.cql
kubectl exec -i $pod_name cqlsh < assets/scripts/cassandra/infrastructure/akka/tables/tag_write_progress.cql



kubectl port-forward $(kubectl get pod -l app.kubernetes.io/name=grafana -o jsonpath="{.items[0].metadata.name}")  3000:3000 &
kubectl port-forward $(kubectl get pod -l app=pcs-cluster -o jsonpath='{.items[0].metadata.name}') 8081:8081 &
kubectl port-forward $(kubectl get pod -l app=pcs-cluster -o jsonpath='{.items[1].metadata.name}') 8082:8081 &
kubectl port-forward $(kubectl get pod -l app=pcs-cluster -o jsonpath='{.items[2].metadata.name}') 8082:8081 &
sleep 5

sh .github/workflows/aws/grafana.sh
# sleep 600
sh .github/workflows/aws/grafana_to_pdf/inform_collaborators.sh
fuser -k 3000/tcp
fuser -k 8081/tcp
fuser -k 8082/tcp
fuser -k 8083/tcp