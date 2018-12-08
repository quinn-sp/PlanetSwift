#!/bin/sh

# set the directory to the dir in which this script resides
newPath=`echo $0 | awk '{split($0, a, ";"); split(a[1], b, "/"); for(x = 2; x < length(b); x++){printf("/%s", b[x]);} print "";}'`
cd "$newPath"

PROJECT_DIR="../"
GAXB_EXEC="./gaxb"
mkdir -p "$PROJECT_DIR/Generated"
"$GAXB_EXEC" swift "$PROJECT_DIR/XMLSchema/PlanetSwift.xsd" -t "$PROJECT_DIR/template" -o "$PROJECT_DIR/Generated"
