package main

import (
	"github.com/gin-gonic/gin"
	"github.com/serverless_web_api/config"
	"github.com/serverless_web_api/handler"
)

func main() {
	gin.SetMode(config.EnvConfig.RunMode)
	g := handler.InitRouter()

	if err := g.Run(":" + config.EnvConfig.Port); err != nil {
		panic(err)
	}
}
