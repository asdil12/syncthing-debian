PREFIX=/usr/local

SYNCTHING_VERSION=v0.10.9
SYNCTHING_ARCH=amd64
SYNCTHING_OS=linux

SYNCTHING_DIST=syncthing-${SYNCTHING_OS}-${SYNCTHING_ARCH}-${SYNCTHING_VERSION}

all: make

install: make
	rm -f ${PREFIX}/bin/syncthing
	cp dist/${SYNCTHING_DIST}/syncthing ${PREFIX}/bin/syncthing
	cp bin/st ${PREFIX}/bin/st
	test -f /etc/init.d/syncthing || cp etc/init.d/syncthing /etc/init.d/syncthing

make: bin/st etc/init.d/syncthing dist/${SYNCTHING_DIST}

dist/${SYNCTHING_DIST}: dist/${SYNCTHING_DIST}.tar.gz
	tar -C dist -xvzf $<
	touch dist/${SYNCTHING_DIST}

dist/${SYNCTHING_DIST}.tar.gz:
	mkdir -p dist
	cd dist && wget https://github.com/calmh/syncthing/releases/download/${SYNCTHING_VERSION}/${SYNCTHING_DIST}.tar.gz

clean:
	rm -r dist
