

apt-get update && apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
curl -sL https://deb.nodesource.com/setup_14.x | bash
curl -s "https://get.sdkman.io" | bash

echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list
apt-get update
apt-get install -y kubectl kafkacat git curl unzip zip gettext-base nodejs



source "$HOME/.sdkman/bin/sdkman-init.sh"
sdkman_auto_answer=true
sdk install sbt 
sdk install java


pip install awscli
curl https://get.docker.com/ | sh
service docker start





