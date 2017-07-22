#!/bin/bash

if [ -f scripts/env.sh ]; then
  echo "*** Importing environment variables ***"
  . scripts/env.sh
else
  echo "The environment file (scripts/env.sh) must exist to deliver the website."
  exit
fi

now=`date +'%m-%d-%Y--%H-%M'`
archive_name=stargateorigins-$now.tgz

echo "*** Build the website ***"
bash scripts/build.sh

if [ ! -d releases ]; then
  echo "*** Create releases folder ***"
  mkdir -p releases;
fi

echo "*** Create package $archive_name ***"
cd build/ && tar -zcf "../releases/$archive_name" . && cd ..
echo "*** Upload the package ***"
scp -P $DELIVERY_PORT releases/$archive_name $DELIVERY_USER@$DELIVERY_SERVER:/home/$DELIVERY_USER/
echo "*** Installing the website ***"
ssh $DELIVERY_USER@$DELIVERY_SERVER "rm -Rf $DELIVERY_DIR*;rm -Rf $DELIVERY_DIR.[!.]*;tar -zxf /home/$DELIVERY_USER/$archive_name -C $DELIVERY_DIR;rm -f /home/$DELIVERY_USER/$archive_name; chmod -R 774 $DELIVERY_DIR; chown -R $DELIVERY_USER:www-data $DELIVERY_DIR"
echo "*** Install completed successfully ***"