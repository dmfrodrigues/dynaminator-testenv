FROM ubuntu:20.04

ENV TZ=Europe/Lisbon
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update
RUN apt-get install -y \
    build-essential \
    ccache \
    cmake \
    curl \
    git \
    lcov \
    nlohmann-json3-dev \
    libwebsocketpp-dev libasio-dev

# Install Catch2
WORKDIR /tmp
RUN git clone https://github.com/catchorg/Catch2.git
WORKDIR /tmp/Catch2/
RUN cmake -Bbuild -H. -DBUILD_TESTING=OFF
RUN cmake --build build/ --target install

# Get assets
RUN mkdir -p /data
WORKDIR /data/
RUN mkdir -p network
RUN mkdir -p network/crossroads1
RUN mkdir -p network/crossroads2
RUN mkdir -p out
RUN mkdir -p dynaminator-data
RUN curl -L https://www.dropbox.com/s/5hwruycfaulksa3/net.net.xml           --output dynaminator-data/porto-armis.net.xml
RUN curl -L https://www.dropbox.com/s/y1obv0hitxysvqk/taz.xml               --output dynaminator-data/porto-armis.taz.xml
RUN curl -L https://www.dropbox.com/s/oobwk5bi4qew4np/matrix.9.0.10.0.2.fma --output dynaminator-data/matrix.9.0.10.0.2.fma
RUN curl -L https://www.dropbox.com/s/1v3hzyoyest33wi/crossroads1.net.xml   --output network/crossroads1/crossroads1.net.xml
RUN curl -L https://www.dropbox.com/s/cz5qvgwofby6x6r/crossroads2.net.xml   --output network/crossroads2/crossroads2.net.xml

# Workdir
RUN mkdir -p /repo
WORKDIR /repo/
