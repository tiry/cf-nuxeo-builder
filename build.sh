#!/bin/bash

NUXEO_VERSION="7.10"
TMP="/tmp"
CF_ENDPOINT="https://api.run.pivotal.io"
CF_LOGIN="tdelprat@nuxeo.com"
# need to define CF_PWD in the environment

echo "Define CF Endpoint";
cf api ${CF_ENDPOINT};
cf login -u ${CF_LOGIN} -p ${CF_PWD}

# download Nuxeo
if [ ! -f ${TMP}/cf-nuxeo-distribution-tomcat.zip ]; then
    echo "downloading ..."
    curl -fsSL "http://cdn.nuxeo.com/nuxeo-${NUXEO_VERSION}/nuxeo-cap-${NUXEO_VERSION}-tomcat.zip" -o ${TMP}/cf-nuxeo-distribution-tomcat.zip ;
fi

# unzip it
if [ -d nuxeo-cap-${NUXEO_VERSION}-tomcat ]; then
      rm -rf nuxeo-cap-${NUXEO_VERSION}-tomcat;
fi

unzip -q -d .  ${TMP}/cf-nuxeo-distribution-tomcat.zip \

# cleanup
#rm -rf /tmp/nuxeo-distribution* 

# make executable
chmod +x nuxeo-cap-${NUXEO_VERSION}-tomcat/bin/*ctl nuxeo-cap-${NUXEO_VERSION}-tomcat/bin/*.sh

NUXEO_CONF=./nuxeo-cap-${NUXEO_VERSION}-tomcat/bin/nuxeo.conf

# update config
cat << EOF >> $NUXEO_CONF
nuxeo.wizard.done=true
EOF

nuxeo-cap-${NUXEO_VERSION}-tomcat/bin/nuxeoctl configure

cp manifest_template.yml nuxeo-cap-${NUXEO_VERSION}-tomcat/manifest.yml

cf push -f nuxeo-cap-${NUXEO_VERSION}-tomcat/manifest.yml





