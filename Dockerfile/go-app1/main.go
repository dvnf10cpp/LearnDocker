package main

import (
	"github.com/gin-gonic/gin" 
)

func main()  {
	app := gin.Default() 

	app.GET("/", func(ctx *gin.Context) {
		ctx.JSON(200, gin.H{
			"message": "hello world", 
		} ) 
	})

	app.Run(":8080") 
} 

