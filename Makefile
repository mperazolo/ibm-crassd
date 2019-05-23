# Makefile for IBM POWER hardware monitor
# Copyright (c) 2017 International Business Machines.  All rights reserved.
JAVAC=/usr/bin/javac
JAR=/usr/bin/jar
JAVAH=/usr/bin/javah
JAVA=/usr/bin/java
CLASSPATH=./classes

# Need to test DESTDIR to see if it is set.  Otherwise set it.

default: java jar
java: ;mkdir -p classes && $(JAVAC) -d  ./classes `find . -name *.java`
clean: ;rm -rf ./classes ./lib
jar: java;mkdir -p ./lib && cd classes/ && $(JAR) -cvfe ../lib/crassd.jar ipmiSelParser.ipmiSelParser * ../ipmiSelParser/*.properties ../ipmiSelParser/resources/*
install: ;cp ./lib/* $(DESTDIR)/lib/
