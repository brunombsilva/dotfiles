export DOCKER_HOST=tcp://172.28.5.254:2376
export DOCKER_TLS_VERIFY=1
export DOCKER_CERT_PATH=$HOME/.docker
alias docker-compose="REQUESTS_CA_BUNDLE=$HOME/.docker/server-cert.pem docker-compose"
