FROM golang:1.21 as builder

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download
COPY . .

ENV CGO_ENABLED=0 GOOS=linux GOARCH=amd64
RUN go build -a -installsuffix cgo -tags lambda.norpc -o main ./cmd/lambda/main.go

FROM public.ecr.aws/lambda/provided:al2023

COPY --from=builder /app/main ./main

ENTRYPOINT ["./main"]
