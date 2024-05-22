package go_crud_gen

import (
	"log"
	"os"
	"strings"
)

func GetModuleNameRoot() string {
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
