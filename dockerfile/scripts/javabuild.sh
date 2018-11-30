#!/bin/bash

# Building all of the Beachfront Java applications

# Create the folder that can be mounted as a volume to share all of the output JARs
mkdir /var/lib/beachfront/target

# Common libraries first
git clone https://github.com/venicegeo/pz-jobcommon.git
pushd pz-jobcommon
mvn -Pbeachfront clean install -DskipTests
popd

# Build all remaining Java projects
declare -a projects=("pz-access"
                     "pz-gateway"
                     "pz-idam"
                     "pz-ingest"
                     "pz-jobmanager"
                     "pz-servicecontroller")
                   #  "bf-api") BROKEN
for project in "${projects[@]}"
do
  git clone https://github.com/venicegeo/$project
  pushd $project
  mvn org.codehaus.mojo:versions-maven-plugin:2.7:use-dep-version -Dincludes=org.venice.piazza:pz-jobcommon -DdepVersion=LATEST -DforceVersion=true
  mvn -Pbeachfront clean install -DskipTests || break
  mv target/*.jar /var/lib/beachfront/target
  popd
done