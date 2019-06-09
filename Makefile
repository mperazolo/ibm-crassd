# Makefile for IBM POWER hardware monitor
# Copyright (c) 2017 International Business Machines.  All rights reserved.
JAVAC=/usr/bin/javac
JAR=/usr/bin/jar
JAVAH=/usr/bin/javah
JAVA=/usr/bin/java
CLASSPATH=./classes
RPMDIR=$(shell pwd)/rpm
VER=1.0
REL=1
ARCH=ppc64le
PROD=ibm-crassd
NAME=$(PROD)-$(VER)-$(REL).$(ARCH)

# Need to test DESTDIR to see if it is set.  Otherwise set it.

default: java jar
java: ;mkdir -p classes && $(JAVAC) -d  ./classes `find . -name *.java`
clean: ;rm -rf ./classes ./lib
jar: java;mkdir -p ./lib && cd classes/ && $(JAR) -cvfe ../lib/crassd.jar ipmiSelParser.ipmiSelParser * ../ipmiSelParser/*.properties ../ipmiSelParser/resources/*
install: java jar
	cp ./lib/* $(DESTDIR)/opt/ibm/ras/lib
	cp ./ibm-crassd/*.config $(DESTDIR)/opt/ibm/ras/etc
	cp ./ibm-crassd/*.py $(DESTDIR)/opt/ibm/ras/bin
	cp -R ./ibm-crassd/plugins $(DESTDIR)/opt/ibm/ras/bin
	cp -R ./errl/ppc64le $(DESTDIR)/opt/ibm/ras/bin
	cp ./*.preset $(DESTDIR)/usr/lib/systemd/system-preset
	cp ./*.service $(DESTDIR)/usr/lib/systemd/system

rpm: java jar
	rm -rf $(RPMDIR)
	mkdir $(RPMDIR)
	for i in BUILD BUILDROOT RPMS SOURCES SPECS SRPMS; do mkdir -p $(RPMDIR)/$$i; done
	for i in bin lib etc; do mkdir -p $(RPMDIR)/BUILDROOT/$(NAME)/opt/ibm/ras/$$i; done
	for i in system system-preset; do mkdir -p $(RPMDIR)/BUILDROOT/$(NAME)/usr/lib/systemd/$$i; done
	cp ibm-crassd-ppc64le.spec $(RPMDIR)
	make install DESTDIR=$(RPMDIR)/BUILDROOT/$(NAME)
	rpmbuild --define '_topdir $(RPMDIR)' -bb $(RPMDIR)/ibm-crassd-ppc64le.spec
