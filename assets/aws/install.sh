



aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin 099925565557.dkr.ecr.us-west-2.amazonaws.com


apt-get install sendemail -y
apt-get install libnet-ssleay-perl -y
apt-get install libio-socket-ssl-perl -y

sendemail -f miguelemosreverte@gmail.com -t miguelemosreverte@gmail.com -s smtp.gmail.com:587 -u \
"Asunto" -m "Cuerpo del mensaje" -a assets/scripts/grafana_to_pdf/output.pdf -v -xu miguelemosreverte -xp osopanda -o tls=yes


sudo debconf-set-selections <<< "postfix postfix/mailname string Grafana"
sudo debconf-set-selections <<< "postfix postfix/main_mailer_type string 'Internet Site'"
sudo apt-get install -y mailutils

echo "Message Body Here" | mail -s "Subject Here" miguelemosreverte@gmail.com -A assets/scripts/grafana_to_pdf/output.pdf


git clone https://miguelemosreverte:Alatriste007@github.com/miguelemosreverte/PCS
cd PCS
git checkout AWS
