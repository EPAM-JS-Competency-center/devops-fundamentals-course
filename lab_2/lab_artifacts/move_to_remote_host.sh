#!/bin/bash

SERVER_HOST_DIR=$(pwd)/nestjs-rest-api
CLIENT_HOST_DIR=$(pwd)/shop-react-redux-cloudfront

# destination folder names can be changed
SERVER_REMOTE_DIR=/var/app/nestjs-rest-api
CLIENT_REMOTE_DIR=/var/www/shop-client

CRT=/usr/local/etc/ssl/certs/self-signed.crt;
CRT_KEY=/usr/local/etc/ssl/private/self-signed.key;
SSH_USER=ubuntu-sshuser;


check_remote_dir_exists() {
  echo "Check if remote directories exist"

  if ssh $SSH_USER "[ ! -d $1 ]"; then
    echo "Creating: $1"
	ssh -t $SSH_USER "sudo bash -c 'mkdir -p $1 && chown -R sshuser: $1'"
  else
    echo "Clearing: $1"
    ssh $SSH_USER "sudo -S rm -r $1/*"
  fi
}

check_remote_dir_exists $SERVER_REMOTE_DIR
check_remote_dir_exists $CLIENT_REMOTE_DIR

echo "---> Building and copying server files - START <---"
echo $SERVER_HOST_DIR
cd $SERVER_HOST_DIR && npm run build
scp -Cr dist/ package.json ecosystem.config.js $SSH_USER:$SERVER_REMOTE_DIR
echo "---> Building and transferring server - COMPLETE <---"

echo "---> Building and transferring client files, cert and ngingx config - START <---"
echo $CLIENT_HOST_DIR
cd $CLIENT_HOST_DIR && npm run build && cd ../
scp -Cr $CLIENT_HOST_DIR/dist/* $CRT $CRT_KEY $CLIENT_HOST_DIR/nginx.conf $SSH_USER:$CLIENT_REMOTE_DIR
echo "---> Building and transferring - COMPLETE <---"
