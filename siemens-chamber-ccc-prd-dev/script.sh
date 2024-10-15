export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/go/bin"
export HOME=/root

#exec 2>&1
exec > >(tee -a /tmp/log) 2>&1

export CODE_DIR=$(echo $BASH_SOURCE | cut -d'/' -f1-3)
cd $CODE_DIR
find $CODE_DIR
env

set -x

# CONFIGS
export GIT_URL="https://gitlab.com/cycloidio/siemens-cfg-license-chamber.git"
export GIT_USERNAME="repo-read"
export GIT_URL_IAC_VARIANTS=https://gitlab.com/cycloidio/siemens-iac-variants.git
export GIT_URL_IAC_LICENSE_CHAMBER=https://gitlab.com/cycloidio/siemens-iac-license-chamber.git
export GIT_BRANCH_IAC_LICENSE_CHAMBER=main

apk update
apk add -q --no-progress git git-subtree rsync

# GIT AUTH
export GIT_URL=$(echo $GIT_URL | awk -F'//' '{print $2}' | cut -d'/' -f1)
git config --global credential.helper 'store --file ~/.git-credentials'

echo https://${GIT_USERNAME}:${GIT_PASSWORD}@$GIT_URL > ~/.git-credentials

# --- start Hack to get git locally
TEMP=$(mktemp -d)
rsync -av ./ $TEMP/
export GIT_URL_CFG_LICENSE_CHAMBER=https://gitlab.com/cycloidio/siemens-cfg-license-chamber.git
git init .
git remote add origin $GIT_URL_CFG_LICENSE_CHAMBER
git config --global credential.helper 'store --file ~/.git-credentials'
git fetch origin
git checkout $GIT_BRANCH_IAC_LICENSE_CHAMBER --force 
rsync -av $TEMP/ ./
git add .
git commit -m "hack"
rm -rf $TEMP
# --- end hack

# GIT SUBTREE
git config --global user.email "you@example.com"
git config --global user.name "Your Name"

# IAC
git remote add -f license $GIT_URL_IAC_LICENSE_CHAMBER

git subtree add --prefix versions/1.05/code license 1.05 --squash
# Variants
git remote add -f variants $GIT_URL_IAC_VARIANTS
git subtree add --prefix variants/1.02/license-chamber variants 1.02 --squash

rsync -av variants/1.02/license-chamber/1.02/license-chamber/license1/ $CY_chamber_config_path/

echo "sleeping ..."
sleep 120
