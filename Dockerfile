FROM debian:bullseye-slim as builder

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
        dos2unix

WORKDIR /vice-emu

RUN svn checkout -r 40671 https://svn.code.sf.net/p/vice-emu/code/trunk trunk

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
        --disable-parsid \
        --disable-portaudio \
        --disable-ssi2001 \
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

FROM debian:bullseye-slim

COPY --from=builder /vice-emu/trunk/vice/*.deb /vice-emu-deb/
RUN dpkg -i /vice-emu-deb/*.deb

RUN apt-get update && \
    apt-get install --yes \
        libgtk-3-0 \
        libglew2.1 \
        libvte-2.91-0 \
        libgomp1 \
        procps \
        net-tools \
        x11vnc \
        xvfb \
        novnc && \
    rm -rf /var/lib/apt/lists/*

COPY ./index.html /usr/share/novnc/index.html
COPY ./start.sh /start.sh

RUN chmod +x /start.sh

CMD ["/start.sh"]
