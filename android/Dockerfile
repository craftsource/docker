# MIT License

# Copyright (c) 2019 Todd Jason Lehn

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
FROM debian:stretch

# Setup the enviornment. Each value can be overridden by setting the enviornment
# at runtime.
ENV SDK_VERSION=29.0.2 \
    ANDROID_HOME=/opt/android-sdk-linux \
    SDK_TOOLS_DIST=sdk-tools-linux-4333796.zip

ENV PATH=${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/build-tools/${SDK_VERSION}

# Use the distro's package manager to isntall the required bits, including i386 libraries and
# download the Android SDK distribution, setup all the required files and directories, install
# the SDK and build tools with the Android SDK manager and cleanup once the install is complete.
RUN dpkg --add-architecture i386 && \
    apt-get update -qq && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y -qq \
    libc6:i386 libstdc++6:i386 libgcc1:i386 libncurses5:i386 libz1:i386 \
    openjdk-8-jdk wget unzip bash openssl < /dev/null > /dev/null && \
    apt-get clean && \
    cd /opt && \
    wget -q https://dl.google.com/android/repository/${SDK_TOOLS_DIST} -O android-sdk-tools.zip && \
    cd /root && \
    mkdir .android && \
    cd .android && \
    touch repositories.cfg && \
    cd /opt && \
    unzip -q android-sdk-tools.zip -d ${ANDROID_HOME} && \
    rm -f android-sdk-tools.zip && \
    yes | sdkmanager --licenses > /dev/null && \
    sdkmanager --update && \
    sdkmanager "build-tools;19.1.0" \
    "build-tools;20.0.0" \
    "build-tools;21.1.2" \
    "build-tools;22.0.1" \
    "build-tools;23.0.1" \
    "build-tools;23.0.2" \
    "build-tools;23.0.3" \
    "build-tools;24.0.0" \
    "build-tools;24.0.1" \
    "build-tools;24.0.2" \
    "build-tools;24.0.3" \
    "build-tools;25.0.0" \
    "build-tools;25.0.1" \
    "build-tools;25.0.2" \
    "build-tools;25.0.3" \
    "build-tools;26.0.0" \
    "build-tools;26.0.1" \
    "build-tools;26.0.2" \
    "build-tools;26.0.3" \
    "build-tools;27.0.0" \
    "build-tools;27.0.1" \
    "build-tools;27.0.2" \
    "build-tools;27.0.3" \
    "build-tools;28.0.0" \
    "build-tools;28.0.1" \
    "build-tools;28.0.2" \
    "build-tools;28.0.3" \
    "build-tools;29.0.0" \
    "build-tools;29.0.1" \
    "build-tools;29.0.2"