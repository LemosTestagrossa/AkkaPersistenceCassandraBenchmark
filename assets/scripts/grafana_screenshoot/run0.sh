DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

echo $DIR

docker run -u root --shm-size 1G --rm \
 --net=host \
 -v $DIR/screenshots:/screenshots \
 grafana-screenshot  "admin:prom-operator" 'http://0.0.0.0:3001/d/DGR-COP-SUJETO_TRI/dgr-cop-sujeto_tri?orgId=1&refresh=10s'
