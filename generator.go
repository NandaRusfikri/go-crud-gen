package go_crud_gen

import (
	"embed"
	"fmt"
	"os"
	"path/filepath"
	"strings"
	"text/template"
)

//go:embed templates/*
var templates embed.FS

func Generate(moduleName, outputDir string) error {
	templates := map[string]string{
		"repo_model":  "templates/outbound/model/model.go.tpl",
		"repo_init":   "templates/outbound/db/module/impl/init.go.tpl",
		"repo_iface":  "templates/outbound/db/module/interface.go.tpl",
		"repo_create": "templates/outbound/db/module/impl/create.go.tpl",
		"repo_update": "templates/outbound/db/module/impl/update.go.tpl",
		"repo_delete": "templates/outbound/db/module/impl/delete.go.tpl",
		"repo_get":    "templates/outbound/db/module/impl/get.go.tpl",

		"usecase_model":  "templates/usecase/model/model.go.tpl",
		"usecase_init":   "templates/usecase/module/impl/init.go.tpl",
		"usecase_iface":  "templates/usecase/module/interface.go.tpl",
		"usecase_create": "templates/usecase/module/impl/create.go.tpl",
		"usecase_update": "templates/usecase/module/impl/update.go.tpl",
		"usecase_delete": "templates/usecase/module/impl/delete.go.tpl",
		"usecase_get":    "templates/usecase/module/impl/get.go.tpl",
	}

	moduleNameRoot := GetModuleNameRoot()

	for kind, tmplFile := range templates {
		fmt.Printf("kind:%s , tmplFile:%s\n", kind, tmplFile)
		err := generateFile(moduleName, moduleNameRoot, tmplFile, kind, outputDir)
		if err != nil {
			return err
		}
	}

	return nil
}

func generateFile(moduleName, moduleNameRoot, tmplFile, kind, outputDir string) error {
	tmpl, err := template.ParseFS(templates, tmplFile)
	if err != nil {
		return fmt.Errorf("failed to parse template: %w", err)
	}

	outputFile := getOutputFilePath(kind, moduleName, outputDir)
	outputDirPath := filepath.Dir(outputFile)
	err = os.MkdirAll(outputDirPath, os.ModePerm)
	if err != nil {
		return fmt.Errorf("failed to create output directory: %w", err)
	}

	f, err := os.Create(outputFile)
	if err != nil {
		return fmt.Errorf("failed to create output file: %w", err)
	}
	defer f.Close()

	data := map[string]string{
		"ModuleName":      moduleName,
		"ModuleNameRoot":  moduleNameRoot,
		"ModuleNameLower": strings.ToLower(moduleName),
	}

	err = tmpl.Execute(f, data)
	if err != nil {
		return fmt.Errorf("failed to execute template: %w", err)
	}

	return nil
}

func getOutputFilePath(kind, moduleName, outputDir string) string {
	var outputFile string
	switch kind {
	case "repo_model":
		outputFile = filepath.Join(outputDir, "internal", "outbound", "model", strings.ToLower(moduleName)+".go")
	case "repo_init":
		outputFile = filepath.Join(outputDir, "internal", "outbound", "db", strings.ToLower(moduleName), "impl", "init.go")
	case "repo_iface":
		outputFile = filepath.Join(outputDir, "internal", "outbound", "db", strings.ToLower(moduleName), strings.ToLower(moduleName)+".go")
	case "repo_create":
		outputFile = filepath.Join(outputDir, "internal", "outbound", "db", strings.ToLower(moduleName), "impl", "create.go")
	case "repo_update":
		outputFile = filepath.Join(outputDir, "internal", "outbound", "db", strings.ToLower(moduleName), "impl", "update.go")
	case "repo_delete":
		outputFile = filepath.Join(outputDir, "internal", "outbound", "db", strings.ToLower(moduleName), "impl", "delete.go")
	case "repo_get":
		outputFile = filepath.Join(outputDir, "internal", "outbound", "db", strings.ToLower(moduleName), "impl", "get.go")
	case "usecase_model":
		outputFile = filepath.Join(outputDir, "internal", "usecase", "model", strings.ToLower(moduleName)+".go")
	case "usecase_init":
		outputFile = filepath.Join(outputDir, "internal", "usecase", strings.ToLower(moduleName), "impl", "init.go")
	case "usecase_iface":
		outputFile = filepath.Join(outputDir, "internal", "usecase", strings.ToLower(moduleName), strings.ToLower(moduleName)+".go")
	case "usecase_create":
		outputFile = filepath.Join(outputDir, "internal", "usecase", strings.ToLower(moduleName), "impl", "create.go")
	case "usecase_update":
		outputFile = filepath.Join(outputDir, "internal", "usecase", strings.ToLower(moduleName), "impl", "update.go")
	case "usecase_delete":
		outputFile = filepath.Join(outputDir, "internal", "usecase", strings.ToLower(moduleName), "impl", "delete.go")
	case "usecase_get":
		outputFile = filepath.Join(outputDir, "internal", "usecase", strings.ToLower(moduleName), "impl", "get.go")
	}
	return outputFile
}
