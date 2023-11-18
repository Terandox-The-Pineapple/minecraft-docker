#!/bin/bash

SERVER_PATH="/home/minecraft-server/server"

if [[ -z $FORGE ]] ; then echo Forge-Mode disabled ; else {
    echo Forge-Mode enabled
    if test -f ".forge-done.lock" ; then echo Forge already installed ; else {
        echo Starting Forge installation
        FORGE_JAR=forge-*-installer.jar
        java -jar ${FORGE_JAR} --installServer
        rm ${FORGE_JAR}
        if test -f "$SERVER_PATH/user_jvm_args.txt" ; then echo -e "\n-Xmx$MAX_RAM" >> user_jvm_args.txt ; fi
        touch .forge-done.lock
    } fi
} fi

if [[ -z $FABRIC ]] ; then echo Fabric-Mode disabled ; else echo Starting Fabric ; fi

if ! test -f .rcon.lock ; then {
    if test -f server.properties; then {
        sed -i 's/enable-rcon=false/enable-rcon=true/' $SERVER_PATH/server.properties
        sed -i 's/rcon.password=/rcon.password=Uwu666@13-Ara_Ara/' $SERVER_PATH/server.properties
        touch .rcon.lock
    } fi
} fi

echo Starting server

if [[ -z $FORGE && -z $FABRIC ]] ; then {
    echo Minecraft-Vanilla
    if test -f "$SERVER_PATH/run.sh" ; then "$SERVER_PATH/run.sh" ; else {
        SERVER_FILE=*.jar
        java -Xmx$MAX_RAM -jar $SERVER_FILE --nogui
    } fi
} fi 

if [[ -z $FABRIC ]] ; then {
    echo Minecraft-Forge
    if test -f "$SERVER_PATH/run.sh" ; then "$SERVER_PATH/run.sh" ; else {
        FORGE_SERVER=*forge*.jar
        java -Xmx$MAX_RAM -jar $FORGE_SERVER --nogui
    } fi
} else {
    echo Minecraft-Fabric
    if test -f "$SERVER_PATH/run.sh" ; then "$SERVER_PATH/run.sh" ; else {
        FABRIC_SERVER=*fabric*.jar
        java -Xmx$MAX_RAM -jar $FABRIC_SERVER --nogui
    } fi
} fi

exit 0