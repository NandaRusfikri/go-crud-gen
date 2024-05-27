package pkgHelper

import (
	"context"
	"go.elastic.co/apm"
	"runtime"
	"strings"
)

func GetCurrentFuncName() string {
	pc, _, _, ok := runtime.Caller(2)
	if !ok {
		// fmt.Sprintf("%+v, %+v")

		return ""
	}

	funcObj := runtime.FuncForPC(pc)
	if funcObj == nil {
		// sdklog.Debug(context.Background(), "[GetCurrentFuncName]Failed to get function object")

		return ""
	}

	funcName := funcObj.Name()

	// Extract just the function name:
	parts := strings.Split(funcName, ".")
	return parts[len(parts)-1]
}

func UpdateCtxSpanUsecase(ctx context.Context) (*apm.Span, context.Context) {
	return apm.StartSpan(ctx, GetCurrentFuncName(), "usecase")
}

func UpdateCtxSpanController(ctx context.Context) (*apm.Span, context.Context) {
	return apm.StartSpan(ctx, GetCurrentFuncName(), "controller")
}

func UpdateCtxSpanRepository(ctx context.Context) (*apm.Span, context.Context) {
	return apm.StartSpan(ctx, GetCurrentFuncName(), "repository")
}
