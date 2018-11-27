#!/bin/bash

# Building all of the required Beachfront applications
git clone https://github.com/venicegeo/pz-jobcommon.git
pushd pz-jobcommon
mvn clean install
popd
