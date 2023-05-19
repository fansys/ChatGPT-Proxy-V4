FROM golang:1.20.4-alpine3.18 as builder

WORKDIR $GOPATH/src/github.com/fansys/ChatGPT-Proxy-V4

ENV GO111MODULE on
ENV GOPROXY https://goproxy.io

COPY . $GOPATH/src/github.com/fansys/ChatGPT-Proxy-V4
RUN go build .

FROM alpine:3.18
LABEL maintainer="Fansy"
RUN apk add tzdata && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone && \
    apk del tzdata

WORKDIR /app
COPY --from=builder /go/src/github.com/fansys/ChatGPT-Proxy-V4/ChatGPT-Proxy-V4 .
CMD [ "/app/ChatGPT-Proxy-V4" ]
