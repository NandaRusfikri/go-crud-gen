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

## Generate 
``` shell
go run cmd/main.go --module=Product --output=./
```
