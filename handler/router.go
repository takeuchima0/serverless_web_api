package handler

import (
	"net/http"

	"github.com/gin-gonic/gin"
	v1 "github.com/serverless_web_api/handler/v1"
)

func InitRouter() *gin.Engine {
	r := gin.New()
	r.Use(gin.Logger())
	r.Use(gin.Recovery())

	apiV1 := r.Group("/api/v1")
	apiV1.Use()
	{
		apiV1.GET("/healthcheck", func(c *gin.Context) {
			c.JSON(http.StatusOK, gin.H{})
		})

		apiV1.GET("/users/:id", v1.GetUser)
	}

	return r
}
