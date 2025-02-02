FROM golang as builder
WORKDIR /app
COPY go.mod go.sum ./
ENV GOPROXY=https://goproxy.cn,direct
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .
FROM alpine:latest
RUN apk add --no-cache tzdata
ENV TZ=Asia/Shanghai
COPY --from=builder /app/main /app/main
EXPOSE 8080
CMD ["/app/main"]