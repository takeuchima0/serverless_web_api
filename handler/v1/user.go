package v1

import (
	"net/http"

	"github.com/astaxie/beego/validation"
	"github.com/gin-gonic/gin"
	"github.com/serverless_web_api/pkg/app"
	"github.com/serverless_web_api/pkg/e"
	"github.com/unknwon/com"
)

func GetUser(c *gin.Context) {
	ag := app.Gin{C: c}
	id := com.StrTo(c.Param("id")).MustInt() // ユーザーIDをパスパラメータから取得

	valid := validation.Validation{}
	result := valid.Min(id, 1, "id").Message("ID must be greater than 0")

	if result.Error != nil {
		app.MarkErrors(valid.Errors)
		ag.Response(http.StatusBadRequest, e.INVALID_PARAMS, result.Error)
		return
	}

	// userService := // ここでロジックを呼び出してモデル情報の取得うんぬんを行う

	user := gin.H{
		"id":       id,
		"username": "test",
		"email":    "hoge@example.com",
	}

	ag.Response(
		http.StatusOK,
		e.SUCCESS,
		user,
	)
}
