DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

echo $DIR

docker run -u root --shm-size 1G --rm \
 --net=host \
 -v $DIR:/app \
 -v $DIR/screenshots:/screenshots \
 alekzonder/puppeteer:latest \
 node screenshot.js 'http://0.0.0.0:3001/d/DGR-COP-SUJETO_TRI/dgr-cop-sujeto_tri?orgId=1&refresh=10s'


 sudo docker run -u root --rm -v $DIR/screenshots:/screenshots \
  alekzonder/puppeteer:latest \
  full_screenshot 'https://www.github.com' 1366x768
