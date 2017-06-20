#! /bin/sh
# appLariats generic websphere build script
# Requirements - A valid war file exists within the src_dir
# Copies the war file from the src_dir and copies it into /config/dropins

#Log everything in /src/build.log
logfile=/src/build.log
exec > $logfile 2>&1
set -x

#Clean up potential leftovers
rm -rf /config/dropins/*

#Check for *.war files and throw error if not present
if ls /src/*.war 1> /dev/null 2>&1
then
 cp -f /src/*.war /config/dropins
else
 echo "ERROR! did not find any *.war file"
 exit 1
fi
