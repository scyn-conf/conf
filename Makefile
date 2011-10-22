#!/bin/bash
SCRIPT=./tools/install.sh
PROJECT=conf

all: install


install:
	${SCRIPT}

uninstall:
	${SCRIPT} --uninstall

clean-backups:
	${SCRIPT} --clean

clean:
	find . -name "*~" -delete
	find . -name ".*.sw*" -delete

dist: clean
	tar  cjvf /tmp/scyn-conf_`date "+%Y-%m-%d"`.tar.bz2 ../conf
