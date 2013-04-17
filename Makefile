#!/bin/bash
SCRIPT=./install.sh
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
	tar  --exclude-vcs -cjvf /tmp/scyn-conf_`date "+%Y-%m-%d"`.tar.bz2 ../conf
