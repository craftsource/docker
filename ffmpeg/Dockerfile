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

RUN		git clone --depth 1 git://git.code.sf.net/p/opencore-amr/fdk-aac && \
			cd fdk-aac && \
			autoreconf -fiv && \
			./configure --prefix="/usr/local" --disable-shared && \
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

RUN		curl -O http://downloads.xiph.org/releases/ogg/libogg-1.3.2.tar.gz && \
			tar xzvf libogg-1.3.2.tar.gz && \
			cd libogg-1.3.2 && \
			./configure --prefix="/usr/local" --disable-shared && \
			make && make install distclean && \
			cd ..

RUN		curl -O http://downloads.xiph.org/releases/vorbis/libvorbis-1.3.4.tar.gz && \
			tar xzvf libvorbis-1.3.4.tar.gz && \
			cd libvorbis-1.3.4 && \
			export LD_LIBRARY_PATH=/usr/local/lib && \
			./configure --prefix="/usr/local" --with-ogg="/usr/local" --disable-shared && \
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

RUN		curl -O http://ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2 && \
			tar xjvf ffmpeg-snapshot.tar.bz2 && \
			cd ffmpeg && \
			./configure --prefix="/usr/local" \
			--pkg-config-flags="--static" \
			--extra-cflags="-I/usr/local/include" \
			--extra-ldflags="-L/usr/local/lib -ldl" \
			--disable-debug \
    			--disable-doc \
			--disable-shared \
			--enable-version3 \
			--enable-static \
			--enable-runtime-cpudetect \
			--enable-avresample \
			--enable-gpl \
			--enable-nonfree \
			--enable-libfdk_aac \
			--enable-libfreetype \
			--enable-libvorbis \
			--enable-libvpx \
			#--enable-libx265  \
			--enable-libx264 && \
 			make && \
 			make install && \
 			hash -r

RUN		yum clean all
RUN		rm -rfv ${WORKDIR}/ffmpeg

ENTRYPOINT  ["/usr/local/bin/ffmpeg"]
