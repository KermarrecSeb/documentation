#!/bin/sh -e
export JAVA_HOME=`/usr/libexec/java_home -v 1.7.0_79`

# Paramètre de génération de la release
releaseVersion=1.0.0.0
tagVersion=release-1.0.0.0

# Paramètre snapshot
developVersion=1-SNAPSHOT

echo "Version Realease = " $releaseVersion
echo "version Develop  = " $developVersion
echo "version Tag      = " $tagVersion

echo "===================================PREPARE DRY=========================================="
mvn clean release:prepare -DdryRun=true -Dresume=false -DreleaseVersion=$releaseVersion -DdevelopmentVersion=$developVersion -Dtag=$tagVersion || exit 1
echo "===================================GREP================================================="
grep -C 2 SNAPSHOT $(find . -name pom.xml.tag) && exit 1

echo "===================================PREPARE=============================================="
mvn clean release:prepare -Dresume=false -DreleaseVersion=$releaseVersion -DdevelopmentVersion=$developVersion -Dtag=$tagVersion || exit 1

echo "===================================PERFORM=============================================="
mvn release:perform || exit 1

echo "===================================CLEAN================================================"
mvn release:clean || exit 1
