# Docker image to set up reverse Tunnel

With this image you can start a container that will connect to a jump server and set up a Port forwarding from the remote host to the specified target on the local network.

## usage Example

Generate Keypair: `ssh-keygen -t ed25519 -C "tunnel-test" -f .sshclient/tunnel_ed25519`

~~~yaml
version: '3.7'

services:
  sshclient:
    image: wolke77/sshclient-gateway:latest
    restart: unless-stopped
    volumes:
      - ./sshclient:/sshclient
    environment:
      - SSH_REMOTE_USER=ansible
      - SSH_REMOTE_HOST=jumpserver.example.com
      - SSH_REMOTE_PORT=22
      - TUN_REMOTE_BIND_ADDRESS=127.22.0.1 # requires sshd_config GatewayPort clientspecified. Otherwise will default to localhost
      - TUN_REMOTE_BIND_PORT=22022
      - TUN_TARGET_HOST=server1.lan
      - TUN_TARGET_PORT=22
~~~

The sshclient runs as user sshclient with uid/gid `101:101`. The ssh key needs to be readable by that user.

## Other use cases

Instead of ssh, it can also be used to forward http or any other port.

The gateway.sh script is just the default command. it can be overwritten to start a simple `/bin/bash` or another `ssh` or `git` command

Launch shell: `docker-compose run sshclient /bin/bash`
