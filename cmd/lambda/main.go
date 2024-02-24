package main

import (
	"fmt"
	"log"
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/serverless_web_api/config"
	"github.com/serverless_web_api/handler"
)

func main() {
	gin.SetMode(config.EnvConfig.RunMode)

	routersInit := handler.InitRouter()
	readTimeout := config.EnvConfig.ReadTimeout
	writeTimeout := config.EnvConfig.WriteTimeout
	maxHeaderBytes := 1 << 20
	addr := fmt.Sprintf(":%s", config.EnvConfig.Port)

	server := &http.Server{
		Addr:           addr,
		Handler:        routersInit,
		ReadTimeout:    readTimeout,
		WriteTimeout:   writeTimeout,
		MaxHeaderBytes: maxHeaderBytes,
	}

	log.Printf("Listening and serving HTTP on %s\n", addr)

	if err := server.ListenAndServe(); err != nil {
		log.Fatalf("Failed to start server: %v", err)
	}
}
