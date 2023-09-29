#!/bin/bash
if [[ -z $FORGE ]] ; then echo Forge-Mode disabled ; else {
    echo Forge-Mode enabled
    if test -f ".forge-done" ; then echo Forge already installed ; else {
        echo Starting Forge installation
        FORGE_JAR=forge-*-installer.jar
        java -jar ${FORGE_JAR} --installServer
        rm ${FORGE_JAR}
        if test -f "user_jvm_args.txt" ; then echo "-Xmx$MAX_RAM" >> user_jvm_args.txt ; fi
        touch .forge-done
    } fi
} fi

echo Starting server


if [[ -z $FORGE && -z $FABRIC ]] ; then {
    if test -f "run.sh" ; then ./run.sh ; else {
        SERVER_FILE=*.jar
        java -Xmx$MAX_RAM -jar $SERVER_FILE --nogui
    } fi
} else if [[ -z $FABRIC ]] ; then {
    if test -f "run.sh" ; then ./run.sh ; else {
        FORGE_SERVER=*forge*.jar
        java -Xmx$MAX_RAM -jar $FORGE_SERVER --nogui
    } fi
} else {
    if test -f "run.sh" ; then ./run.sh ; else {
        FABRIC_SERVER=*fabric*.jar
        java -Xmx$MAX_RAM -jar $FABRIC_SERVER --nogui
    } fi
} fi

exit 0