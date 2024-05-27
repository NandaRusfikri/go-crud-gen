# Golang CRUD Generator
This Library can generate crud repository and usecase 

# Install
```shell
go get github.com/NandaRusfikri/go-crud-gen
```

## Usage
```go
package main

import (
	"flag"
	gen "github.com/NandaRusfikri/go-crud-gen"
	"log"
)

func main() {
	moduleName := flag.String("module", "", "The name of the module to pkg")
	outputDir := flag.String("output", ".", "The output directory for the generated files")
	flag.Parse()

	if *moduleName == "" {
		log.Fatal("module name is required")
	}
	
	err := gen.Generate(*moduleName,  *outputDir)
	if err != nil {
		log.Fatalf("Error generating module: %v", err)
	}

	log.Printf("Module %s generated successfully", *moduleName)
}
```

### create file for span
create file in root/pkg/helper.span.go
```go
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

```

### create file for model outbound
Create file in root/pkg/resource/model/model.go
```go
package model

import (
	"gorm.io/gorm"
)

type Database struct {
	Template *gorm.DB
	Oracle   *gorm.DB
}

```

## Generate 
``` shell
go run cmd/main.go --module=Product --output=./
```
