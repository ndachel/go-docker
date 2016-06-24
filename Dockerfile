FROM ubuntu:14.04
ENV http_proxy=http://web-proxy.corp.hpecorp.net:8080
ENV https_proxy=http://web-proxy.corp.hpecorp.net:8080

RUN apt-get update
RUN apt-get install -y wget net-tools

WORKDIR /root
RUN mkdir /go
# set golang env
ENV HOME /root
ENV VERSION 1.5
ENV OS linux
ENV ARCH amd64
RUN wget http://golang.org/dl/go$VERSION.$OS-$ARCH.tar.gz -q -O - | tar -zxf - -C /usr/local
ENV GOPATH /go
ENV GOROOT /usr/local/go
ENV PATH $PATH:$GOPATH/bin:$GOROOT/bin

VOLUME [ "/go" ]

RUN apt-get update && apt-get install -y software-properties-common
RUN apt-get -y install \
                vim git curl mercurial \
                build-essential cmake \
                python-dev ctags tmux supervisor openssh-server
RUN apt-get clean
ENV HOME /root
WORKDIR /root

CMD ["sh", "/startup.sh"]
RUN apt-get install -y git
