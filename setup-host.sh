set -e

CONFIG_DIR=`pwd`
./bin/docker-generate-certificates
cp -v {ca,cert,key}.pem ~/.docker
sudo ./bin/docker-install
sudo usermod -aG docker $USER

echo DOCKER_OPTS=\"--tlsverify --tlscacert=$CONFIG_DIR/ca.pem --tlscert=$CONFIG_DIR/server-cert.pem --tlskey=$CONFIG_DIR/server-key.pem -H=0.0.0.0:2376\" | sudo tee  /etc/default/docker
sudo service docker restart
export DOCKER_HOST=tcp://`hostname`:2376 DOCKER_TLS_VERIFY=1
