#!/bin/sh

# connect to remote host and set up reverse tunnel

set -e

SSH_OPTIONS="-o StrictHostKeyChecking=accept-new -o ExitOnForwardFailure=yes -o UserKnownHostsFile=/sshclient/known_hosts"

if [ -n "$SSH_REMOTE_HOST" ]; then
  if [ -f $SSH_PRIVATE_KEY ]; then
    mkdir -p /home/sshclient/.ssh
    cp -f $SSH_PRIVATE_KEY /home/sshclient/.ssh/tunnel_key
    chmod 0600 /home/sshclient/.ssh/tunnel_key
    ssh ${SSH_OPTIONS} -i /home/sshclient/.ssh/tunnel_key ${SSH_REMOTE_USER}@${SSH_REMOTE_HOST} -p ${SSH_REMOTE_PORT} -N -R ${TUN_REMOTE_BIND_ADDRESS}:${TUN_REMOTE_BIND_PORT}:${TUN_TARGET_HOST}:${TUN_TARGET_PORT} -v
  else
    echo "Missing private key '${SSH_PRIVATE_KEY}'"
    exit 1
  fi
else
  echo "\$SSH_REMOTE_HOST is not set, exiting"
  exit 1
fi
