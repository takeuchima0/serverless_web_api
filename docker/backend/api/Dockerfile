FROM golang:1.21 as builder

WORKDIR /app
COPY go.mod .
COPY go.sum .
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -installsuffix cgo -o main ./cmd/lambda/main.go

FROM gcr.io/distroless/base-debian12

WORKDIR /root/
COPY --from=builder /app/main .

CMD ["./main"]
