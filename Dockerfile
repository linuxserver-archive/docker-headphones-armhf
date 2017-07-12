FROM lsiobase/alpine.python.armhf:3.6
MAINTAINER smdion <me@seandion.com> ,sparklyballs

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"

# copy patches folder
COPY patches/ /tmp/patches/

# install build packages
RUN \
 apk add --no-cache --virtual=build-dependencies \
	g++ \
	gcc \
	make && \

# install runtime packages
 apk add --no-cache \
	ffmpeg \
	flac \
	mc && \

# compile shntool
 mkdir -p \
	/tmp/shntool && \
 tar xf /tmp/patches/shntool-3.0.10.tar.gz -C \
	/tmp/shntool --strip-components=1 && \
 cp /tmp/patches/config.* /tmp/shntool && \
 cd /tmp/shntool && \
 ./configure \
	--infodir=/usr/share/info \
	--localstatedir=/var \
	--mandir=/usr/share/man \
	--prefix=/usr \
	--sysconfdir=/etc && \
 make && \
 make install && \

# cleanup
 apk del --purge \
	build-dependencies && \
 rm -rf \
	/tmp/* \
	/usr/lib/*.la

# add local files
COPY root/ /

# ports and volumes
EXPOSE 8181
VOLUME /config /downloads /music
