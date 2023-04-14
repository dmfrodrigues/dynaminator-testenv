FROM ubuntu:20.04

ENV TZ=Europe/Lisbon
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update
RUN apt-get install -y \
    cmake \
    curl \
    git \
    nlohmann-json3-dev \
    libwebsocketpp-dev libasio-dev

# Install Catch2
RUN git clone https://github.com/catchorg/Catch2.git
RUN cd Catch2/
RUN cmake -Bbuild -H. -DBUILD_TESTING=OFF
RUN sudo cmake --build build/ --target install

# Get assets
RUN mkdir -p /repo
WORKDIR /repo/
RUN mkdir -p data/network
RUN mkdir -p data/network/crossroads1
RUN mkdir -p data/network/crossroads2
RUN mkdir -p data/od
RUN mkdir -p data/out
RUN curl -L https://www.dropbox.com/s/5hwruycfaulksa3/net.net.xml --output data/network/net.net.xml
RUN curl -L https://www.dropbox.com/s/y1obv0hitxysvqk/taz.xml --output data/network/taz.xml
RUN curl -L https://www.dropbox.com/s/oobwk5bi4qew4np/matrix.9.0.10.0.2.fma --output data/od/matrix.9.0.10.0.2.fma
RUN curl -L https://www.dropbox.com/s/1v3hzyoyest33wi/crossroads1.net.xml --output data/network/crossroads1/crossroads1.net.xml
RUN curl -L https://www.dropbox.com/s/cz5qvgwofby6x6r/crossroads2.net.xml --output data/network/crossroads2/crossroads2.net.xml
