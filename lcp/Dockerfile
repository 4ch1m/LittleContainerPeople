FROM debian:bookworm-slim AS builder

RUN apt-get update && \
    apt-get install --yes \
        subversion \
        build-essential \
        checkinstall \
        bison \
        flex \
        xa65 \
        libgtk-3-dev \
        libvte-dev \
        libglew-dev \
        libevdev-dev \
        dos2unix

WORKDIR /vice-emu

# NOTE: revision 45460 == v3.9
RUN svn checkout -r 45460 https://svn.code.sf.net/p/vice-emu/code/trunk trunk

RUN cd trunk/vice/ && \
    ./autogen.sh && \
    ./configure \
        --without-alsa \
        --without-pulse \
        --without-sdlsound \
        --without-sun \
        --without-oss \
        --without-flac \
        --without-vorbis \
        --without-mpg123 \
        --without-png \
        --without-libcurl \
        --disable-parsid \
        --disable-hardsid \
        --disable-portaudio \
        --disable-ssi2001 \
        --disable-catweasel \
        --disable-ipv6 \
        --disable-new8580filter \
        --disable-realdevice \
        --enable-lame=no \
        --enable-midi=no \
        --enable-static-lame=no \
        --enable-external-ffmpeg=no \
        --enable-shared-ffmpeg=no \
        --enable-static-ffmpeg=no \
        --enable-quicktime=no \
        --enable-ethernet=no \
        --enable-html-docs=no \
        --enable-pdf-docs=no \
        --enable-platformdox=no \
        --enable-desktop-files=no \
        --enable-x64 \
        --enable-native-gtk3ui && \
    make && \
    checkinstall \
        --pkgversion 666 \
        --fstrans=no \
        --install=no

FROM debian:bookworm-slim

COPY --from=builder /vice-emu/trunk/vice/*.deb /vice-emu-deb/
RUN dpkg -i /vice-emu-deb/*.deb

ARG VICE_DEPENDENCIES="libgtk-3-0 libglew2.2 libvte-2.91-0 libevdev2 libgomp1"

RUN apt-get update && \
    apt-get install --no-install-recommends --yes \
        ${VICE_DEPENDENCIES} \
        procps \
        net-tools \
        x11vnc \
        xvfb \
        novnc && \
    rm -rf /var/lib/apt/lists/*

COPY ./index.html /usr/share/novnc/index.html
COPY ./start.sh /start.sh

RUN chmod +x /start.sh

EXPOSE 6081

CMD ["/start.sh"]
