package main

import (
	"fmt"
	"log/slog"
	"strings"

	"github.com/aws/aws-lambda-go/lambda"
)

type Event struct {
	Message string `json:"message"`
}

type Response struct {
	Message string `json:"message"`
}

func handleRequest(event Event) (Response, error) {
	slog.Info("Received request")

	if event.Message == "" {
		slog.Error("Message must not be empty")
		return Response{}, fmt.Errorf("message must not be empty")
	}

	slog.Info("Received message", "str", event.Message)

	return Response{
		Message: strings.ToLower(event.Message),
	}, nil
}

func main() {
	lambda.Start(handleRequest)
}
