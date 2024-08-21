FROM golang:alpine AS builder

WORKDIR /app

COPY go.mod ./
COPY main.go ./

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags="-s -w" -o myapp .

FROM scratch

WORKDIR /app

COPY --from=builder /app/myapp .

ENTRYPOINT ["./myapp"]