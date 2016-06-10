FROM ubuntu:16.04

# Install sudo
RUN apt-get update \
  && apt-get -y install sudo \
  && useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo

# Install 32bit lib
RUN sudo apt-get -y install lib32stdc++6 lib32z1

# Install git
RUN apt-get -y install libcurl4-gnutls-dev libexpat1-dev gettext libz-dev libssl-dev \
    && apt-get -y install git

# Install Java8
RUN apt-get install -y software-properties-common curl \
    && add-apt-repository -y ppa:openjdk-r/ppa \
    && apt-get update \
    && apt-get install -y openjdk-8-jdk

# Download Android SDK
RUN sudo apt-get -y install wget \
  && cd /usr/local \
  && wget http://dl.google.com/android/android-sdk_r24.4.1-linux.tgz \
  && tar zxvf android-sdk_r24.4.1-linux.tgz \
  && rm -rf /usr/local/android-sdk_r24.4.1-linux.tgz

# Environment variables
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV ANDROID_HOME /usr/local/android-sdk-linux
ENV PATH $ANDROID_HOME/platform-tools:$ANDROID_HOME/tools:$PATH

# Update of Android SDK
RUN echo y | android update sdk --no-ui --all --filter "android-23,build-tools-23.0.2" \
  && echo y | android update sdk --no-ui --all --filter "extra-google-m2repository,extra-android-m2repository"