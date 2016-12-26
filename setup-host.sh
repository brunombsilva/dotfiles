set -e

CONFIG_DIR=`pwd`
./bin/docker-generate-certificates
cp -v {ca,cert,key}.pem ~/.docker
sudo ./bin/docker-install
sudo usermod -aG docker $USER

echo DOCKER_OPTS=\"--tlsverify --tlscacert=$CONFIG_DIR/ca.pem --tlscert=$CONFIG_DIR/server-cert.pem --tlskey=$CONFIG_DIR/server-key.pem -H=0.0.0.0:2376\" | sudo tee  /etc/default/docker
sudo service docker restart

ln -s `pwd`/docker $HOME/.docker

#ssh-keygen -t rsa -f dotfiles_rsa

echo "add environment variables to .bashrc"

set -x
export DOCKER_HOST=tcp://`hostname`:2376
export DOCKER_TLS_VERIFY=1
export DOCKER_CERT_PATH=$HOME/.docker
export REQUESTS_CA_BUNDLE=$HOME/.docker/server-cert.pem
