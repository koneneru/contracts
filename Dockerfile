FROM golang:1.26

# Install protoc
#ARG PROTOC_VERSION=27.1
#RUN apt-get update && apt-get install -y unzip curl git && rm -rf /var/lib/apt/lists/* && \
#    curl -sSL https://github.com/protocolbuffers/protobuf/releases/download/v${PROTOC_VERSION}/protoc-${PROTOC_VERSION}-linux-x86_64.zip -o /tmp/protoc.zip && \
#    unzip /tmp/protoc.zip -d /usr/local && rm /tmp/protoc.zip

# Install protoc with local copy of protoc.zip
RUN apt-get update && apt-get install -y unzip git && rm -rf /var/lib/apt/lists/*

COPY protoc-27.1-linux-x86_64.zip /tmp/protoc.zip
RUN unzip /tmp/protoc.zip -d /usr/local && rm /tmp/protoc.zip

# Download googleapis into image
RUN git clone --depth=1 https://github.com/googleapis/googleapis /usr/local/include/googleapis

# Install gRPC plugins for protoc
RUN go install google.golang.org/protobuf/cmd/protoc-gen-go@latest && \
    go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest

ENV PATH="$PATH:/go/bin"
WORKDIR /app
