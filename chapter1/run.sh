#!/bin/sh
mvn package exec:java -Dexec.mainClass=CascadingExample -Dexec.cleanupDaemonThreads=false
