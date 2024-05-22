package main

import (
	"flag"
	gen "github.com/NandaRusfikri/go-crud-gen"
	"log"
	"os"
	"strings"
)

func main() {
	moduleName := flag.String("module", "", "The name of the module to pkg")
	outputDir := flag.String("output", ".", "The output directory for the generated files")
	flag.Parse()

	if *moduleName == "" {
		log.Fatal("module name is required")
	}

	moduleNameRoot := getModuleNameRoot()

	err := gen.Generate(*moduleName, moduleNameRoot, *outputDir)
	if err != nil {
		log.Fatalf("Error generating module: %v", err)
	}

	log.Printf("Module %s generated successfully", *moduleName)
}

func getModuleNameRoot() string {
	data, err := os.ReadFile("go.mod")
	if err != nil {
		log.Fatalf("Error reading go.mod file: %v", err)
	}

	lines := strings.Split(string(data), "\n")
	for _, line := range lines {
		if strings.HasPrefix(line, "module") {
			return strings.TrimSpace(strings.TrimPrefix(line, "module"))
		}
	}

	log.Fatal("module name not found in go.mod file")
	return ""
}
