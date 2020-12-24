FROM golang:1.15-alpine AS builder

WORKDIR /usr/src/app

COPY . .
RUN go get -d ./...
RUN go build -v

FROM alpine

# We'll likely need to add SSL root certificates
RUN apk --no-cache add ca-certificates

WORKDIR /usr/local/bin

COPY --from=builder /usr/src/app/sample-golang /usr/local/bin/

CMD ["./sample-golang"]