#!/bin/bash

RVER=4.0.41

RETCODE=$(fw_exists ${IROOT}/resin-${RVER}.installed)
[ ! "$RETCODE" == 0 ] || { \
  # Load environment variables
  . $IROOT/resin-$RVER.installed 
  return 0; }

fw_depends java7
sudo cp -r $JAVA_HOME/include $JAVA_HOME/jre/bin/

fw_get http://www.caucho.com/download/resin-$RVER.tar.gz
fw_untar resin-$RVER.tar.gz
cd resin-$RVER
./configure --prefix=`pwd`
make
make install

mv conf/resin.properties conf/resin.properties.orig
cat $FWROOT/config/resin.properties > conf/resin.properties

mv conf/resin.xml conf/resin.xml.orig
cat $FWROOT/config/resin.xml > conf/resin.xml

echo "export RESIN_HOME=${IROOT}/resin-${RVER}" > ${IROOT}/resin-$RVER.installed
chmod +x ${IROOT}/resin-$RVER.installed

. ${IROOT}/resin-$RVER.installed