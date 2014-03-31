#!/bin/bash

# symlink .netrc for Google Code authentication
# assumes .netrc was copied into the shared folder on the client
# machine by `make install`
sudo ln -fs /vagrant/.netrc /var/lib/jenkins

# install Appengine
APP_ENGINE_DIR=/usr/bin/google_appengine
DOWNLOAD_URL=$1

while [ ! -d "$APP_ENGINE_DIR" ]; do
  cd /usr/bin
  sudo wget --tries=70 --quiet --timeout=30 $DOWNLOAD_URL -O google_appengine.zip
  sudo unzip -q google_appengine.zip
  sudo rm google_appengine.zip
done

# check installation was successful
if [ -d "$APP_ENGINE_DIR" ]; then
  echo "Appengine successfully installed to $APP_ENGINE_DIR"
  cat $APP_ENGINE_DIR/VERSION
else
  echo "WARNING!!! Appengine not found at path $APP_ENGINE_DIR"
fi

# set global env variables
cat <<EOF >> /var/lib/jenkins/.bashrc
PATH=\$PATH:/usr/bin/google_appengine
APP_ENGINE_SDK=/usr/bin/google_appengine
GAE_SDK_ROOT=/usr/bin/google_appengine
EOF
