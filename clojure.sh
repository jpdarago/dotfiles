#!/bin/bash
set -euo pipefail
set -x

# Setup for Clojure

# Java
sudo apt install software-properties-common rlwrap
wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | sudo apt-key add -
sudo add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/
sudo apt-get update
sudo apt-get install -y adoptopenjdk-11-hotspot

# Leiningen
curl -fLo ~/bin/lein https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein
sudo chmod a+x ~/bin/lein

# Clojure
curl -fLo /tmp/clojure.sh https://download.clojure.org/install/linux-install-1.10.3.855.sh
chmod +x /tmp/clojure.sh
sudo /tmp/clojure.sh
