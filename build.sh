#! /bin/sh
# appLariats generic websphere build script


#Log everything in /src/build.log
logfile=/code/build.log
exec > $logfile 2>&1
set -x

#check inside code artifact for /code/tomcat-conf/server.xml and use it if exists
#customizing websphere through providing websphere-conf/server.xml as part of the code artifact
if [ -e /code/websphere-conf/server.xml ]
then
 cp -f /code/websphere-conf/server.xml /config/
else
 #look inside /conf for server.xml and use it if exists
 #customizing websphere through cloning this github repo and providing conf/server.xml
 if [ -e /conf/server.xml ]
 then
  cp -f /conf/server.xml /config/
 fi
 #if non of the above, default config file inside the image will be used
fi

#Clean up potential leftovers
rm -rf /config/dropins/*

#Check for *.war files and throw error if not present
if ls /code/*.war 1> /dev/null 2>&1
then
 cp -f /code/*.war /config/dropins
else
 echo "ERROR! did not find any *.war file"
 exit 1
fi
