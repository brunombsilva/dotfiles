set -e

apt-get -y update
apt-get -y install apt-transport-https ca-certificates
apt-key -y adv \
	--keyserver hkp://ha.pool.sks-keyservers.net:80 \
	--recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" | sudo tee /etc/apt/sources.list.d/docker.list
apt-get -y update
apt-get -y --force-yes install docker-engine

curl -L "https://github.com/docker/compose/releases/download/1.9.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
#curl -L "https://github.com/docker/machine/releases/download/v0.6.0/docker-machine-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-machine

chmod +x /usr/local/bin/docker-*

curl -L https://raw.githubusercontent.com/docker/compose/$(docker-compose version --short)/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose
#curl https://raw.githubusercontent.com/docker/machine/master/contrib/completion/bash/docker-machine-prompt.bash -o /etc/bash_completion.d/docker-machine-prompt.bash
