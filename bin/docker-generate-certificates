#!/bin/bash
#
# Generates client and server certificates used to enable HTTPS
# remote authentication to a Docker daemon.
#
#     See http://docs.docker.com/articles/https/
#
# To start the Docker Daemon:
#
#     sudo docker -d                 \
#         --tlsverify                \
#         --tlscacert=ca.pem         \
#         --tlscert=server-cert.pem  \
#         --tlskey=server-key.pem    \
#         -H=0.0.0.0:2376
#
# To connect to the Docker Daemon:
#
#     sudo docker                    \
#         --tlsverify                \
#         --tlscacert=ca.pem         \
#         --tlscert=cert.pem         \
#         --tlskey=key.pem           \
#         -H=localhost:2376 version
#
# IMPORTANT: when connecting via IP instead of hostname you
#            will need to substitute --tlsverify with --tls

set -e
set -x

HOST=$(hostname)
DAYS=1460
PASS=$(openssl rand -hex 16)

# remove certificates from previous execution.
rm -f *.pem *.srl *.csr *.cnf


# generate CA private and public keys
echo 01 > ca.srl
openssl genrsa -des3 -out ca-key.pem -passout pass:$PASS 2048
openssl req -subj '/CN=*/' -new -x509 -days $DAYS -passin pass:$PASS -key ca-key.pem -out ca.pem

# create a server key and certificate signing request (CSR)
openssl genrsa -des3 -out server-key.pem -passout pass:$PASS 2048
openssl req -new -key server-key.pem -out server.csr -passin pass:$PASS -subj '/CN=*/'

# sign the server key with our CA
echo subjectAltName = DNS:$HOST,IP:172.28.5.254,IP:127.0.0.1 > extfile.cnf
openssl x509 -req -days $DAYS -passin pass:$PASS -in server.csr -CA ca.pem -CAkey ca-key.pem -out server-cert.pem -extfile extfile.cnf

# create a client key and certificate signing request (CSR)
openssl genrsa -des3 -out key.pem -passout pass:$PASS 2048
openssl req -subj '/CN=client' -new -key key.pem -out client.csr -passin pass:$PASS

# create an extensions config file and sign
echo extendedKeyUsage = clientAuth > extfile.cnf
openssl x509 -req -days $DAYS -passin pass:$PASS -in client.csr -CA ca.pem -CAkey ca-key.pem -out cert.pem -extfile extfile.cnf

# remove the passphrase from the client and server key
openssl rsa -in server-key.pem -out server-key.pem -passin pass:$PASS
openssl rsa -in key.pem -out key.pem -passin pass:$PASS

# remove generated files that are no longer required
rm -f ca-key.pem ca.srl client.csr extfile.cnf server.csr

exit 0
