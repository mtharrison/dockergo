FROM ubuntu:latest

# Update OS and install some essential tools
RUN apt-get update -q
RUN DEBIAN_FRONTEND=noninteractive apt-get install -qy build-essential curl git

# Install and configure go
RUN curl -s https://go.googlecode.com/files/go1.2.1.src.tar.gz | tar -v -C /usr/local -xz
RUN cd /usr/local/go/src && ./make.bash --no-clean 2>&1
ENV PATH /usr/local/go/bin:$PATH

# Bundle script
ADD server.go /src/server.go

# Expose port
EXPOSE 8080

# Run server
CMD ["go","run","/src/server.go"]