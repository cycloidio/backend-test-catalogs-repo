#!/bin/bash -v

set -x

apt_wait () {
  while sudo fuser /var/lib/dpkg/lock >/dev/null 2>&1 ; do
    sleep 1
  done
  while sudo fuser /var/lib/apt/lists/lock >/dev/null 2>&1 ; do
    sleep 1
  done
}

apt_wait

apt-get update -y
apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common -y

curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
apt-key fingerprint 0EBFCD88
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"

apt-get update -y
apt-get install docker-ce docker-ce-cli containerd.io -y

docker run -d -it -p 80:80 -e REPO=${git_code_repo} -e COMMIT=${git_code_commit} -e PROJECT=${project} -e ENV=${env} cycloid/step-by-step-nginx
