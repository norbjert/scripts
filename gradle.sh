#!/bin/sh
set -e

# default gradle version (should just be latest probably?)
GRADLE_VERSION="8.12.1"

INSTALL_JDK=""
POSITIONAL="" #() # unused structure
while [ $# -gt 0 ]; do
	case "$1" in
    -h | --help )
      echo "help msg"
      exit 0;
      ;;
      
		-v | --version | --gradle-version )
			GRADLE_VERSION="$2"
			shift; shift
			;;

   		--install-jdk )
			INSTALL_JDK="$2"
      echo "option for installing a jdk not yet supported"
			shift; shift
			;;
   
		--* )
			echo "Illegal option $1"
			;;
    * )
      POSITIONAL+=$1 #("$1")
      shift
      ;;
	esac
done



#makes sure the required jdk is installed, if not installs it as well
#optional, commented out for now, should be enable to toggle this with a prefix
#sudo apt install openjdk-21-jdk -y



echo "configuring environment"

[ ! -d "/opt/gradle" ] && mkdir -p /opt/gradle

[ ! -d "/tmp" ] && mkdir /tmp



echo "downloading the zip from gradle.org..."

wget -P /tmp https://services.gradle.org/distributions/gradle-$GRADLE_VERSION-bin.zip

sudo unzip -o -d /opt/gradle /tmp/gradle-$GRADLE_VERSION-bin.zip

sudo ln -s /opt/gradle/gradle-$GRADLE_VERSION/bin/gradle /usr/bin/gradle

echo "successfully installed gradle version $GRADLE_VERSION"
