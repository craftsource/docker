FROM        centos:latest
MAINTAINER  Todd J. Lehn <lehn.todd@gmail.com>

WORKDIR /tmp

RUN yum upgrade -y

RUN yum --enablerepo=extras install -y epel-release yum-utils

 RUN	yum install -y \
 					autoconf \
					automake \
					bzip2 \
					cmake \
					file 			\
					freetype \
					freetype-devel \
					gcc \
					gcc-c++ \
					gettext \
					git \
					hg 			\
					libtool \
					make \
					mercurial \
					nasm \
					pkgconfig 			\
					xmlto 			\
					which 			\
					zlib-devel

RUN		export MAKEFLAGS="-j$(($(nproc) + 1))"
RUN		echo "/usr/local/lib" > /etc/ld.so.conf.d/libc.conf
RUN		mkdir ffmpeg && cd ffmpeg

RUN		git clone --depth 1 git://github.com/yasm/yasm.git && \
			cd yasm && \
			autoreconf -fiv && \
			./configure --prefix="/usr/local" --bindir="/usr/local/bin" && \
			make && make install distclean && \
			cd ..

RUN		git clone --depth 1 git://git.videolan.org/x264 && \
			cd x264 && \
			./configure --prefix="/usr/local" --bindir="/usr/local/bin" --enable-static && \
			make && make install distclean && \
			cd ..

RUN		hg clone https://bitbucket.org/multicoreware/x265 && \
			cd x265/build/linux && \
			cmake -G "Unix Makefiles" \
			-DCMAKE_INSTALL_PREFIX="/usr/local" \
			-DENABLE_SHARED:bool=off \
			../../source && make && make install && \
			cd ..

RUN		git clone --depth 1 git://git.code.sf.net/p/opencore-amr/fdk-aac && \
			cd fdk-aac && \
			autoreconf -fiv && \
			./configure --prefix="/usr/local" --disable-shared && \
			make && make install distclean && \
			cd ..

RUN		curl -L -O http://downloads.sourceforge.net/project/lame/lame/3.99/lame-3.99.5.tar.gz && \
			tar xzvf lame-3.99.5.tar.gz && \
			cd lame-* && \
			./configure --prefix="/usr/local" --bindir="/usr/local/bin" --disable-shared && \
			make && make install distclean && \
			cd ..

RUN		git clone http://git.opus-codec.org/opus.git && \
			cd opus && \
			autoreconf -fiv && \
			./configure --prefix="/usr/local" --disable-shared && \
			make && make install distclean && \
			cd ..

RUN		curl -O http://downloads.xiph.org/releases/ogg/libogg-1.3.2.tar.gz && \
			tar xzvf libogg-1.3.2.tar.gz && \
			cd libogg-* && \
			./configure --prefix="/usr/local" --disable-shared && \
			make && make install distclean && \
			cd ..

RUN		curl -O http://downloads.xiph.org/releases/vorbis/libvorbis-1.3.4.tar.gz && \
			tar xzvf libvorbis-1.3.4.tar.gz && \
			cd libvorbis-* && \
			export LD_LIBRARY_PATH=/usr/local/lib && \
			./configure --prefix="/usr/local" --with-ogg="/usr/local" --disable-shared && \
			make && make install distclean && \
			cd ..

RUN  	git clone --depth 1 https://chromium.googlesource.com/webm/libvpx.git && \
			cd libvpx/ && \
			./configure --prefix="/usr/local" \
			--disable-examples \
			--enable-vp8 \
			--enable-vp9 \
			--enable-pic \
			--disable-debug \
			--disable-docs && \
			make && make install distclean && \
			cd ..

RUN		curl -O http://ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2 && \
			tar xjvf ffmpeg-snapshot.tar.bz2 && \
			cd ffmpeg && \
			export PKG_CONFIG_PATH="/usr/local/lib/pkgconfig" && \
			./configure --prefix="/usr/local" \
			--pkg-config-flags="--static" \
			--extra-cflags="-I/usr/local/include" \
			--extra-ldflags="-L/usr/local/lib -ldl" \
			--disable-debug \
    	--disable-doc \
			--disable-shared \
			--enable-gpl \
			--enable-nonfree \
			--enable-version3 \
			--enable-static \
			--enable-runtime-cpudetect \
			--enable-avresample \
			--enable-libfdk_aac \
			--enable-libfreetype \
			--enable-libmp3lame \
			--enable-libopus \
			--enable-libvorbis \
			--enable-libvpx \
			--enable-libx265  \
			--enable-libx264 && \
 			make && \
 			make install && \
 			hash -r

RUN		rm -rfv /tmp/lib* && \
			rm -rfv /tmp/lame* && \
			rm -rfv /tmp/opus && \
			rm -rfv /tmp/ffmpeg && \
			rm -rfv /tmp/yasm && \
			rm -rfv /tmp/fdk-aac && \
			rm -rfv /tmp/x* && \
			rm -fv /tmp/*.gz  && \
			rm -fv /tmp/*.bz2

RUN yum erase -y \
					autoconf \
					automake \
					libtool \
					bzip2 \
					freetype-devel \
					cmake \
					gcc \
					gcc-c++ \
					git \
					hg \
					nasm \
					zlib-devel && \
					yum clean all

ENTRYPOINT  ["/usr/local/bin/ffmpeg"]
