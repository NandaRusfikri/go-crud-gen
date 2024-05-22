package go_crud_gen

import (
	"bytes"
	"fmt"
	"os"
	"path/filepath"
	"strings"
	"text/template"
)

func Generate(moduleName, outputDir string) error {
	templates := map[string]string{
		"repo_model":  "templates/repository/db/model/model.go.tpl",
		"repo_init":   "templates/repository/db/module/impl/init.go.tpl",
		"repo_iface":  "templates/repository/db/module/interface.go.tpl",
		"repo_create": "templates/repository/db/module/impl/create.go.tpl",
		"repo_update": "templates/repository/db/module/impl/update.go.tpl",
		"repo_delete": "templates/repository/db/module/impl/delete.go.tpl",
		"repo_get":    "templates/repository/db/module/impl/get.go.tpl",

		"usecase_model":  "templates/usecase/model/model.go.tpl",
		"usecase_init":   "templates/usecase/module/impl/init.go.tpl",
		"usecase_iface":  "templates/usecase/module/interface.go.tpl",
		"usecase_create": "templates/usecase/module/impl/create.go.tpl",
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
	tmplPath := filepath.Join(tmplFile)
	tmpl, err := template.ParseFiles(tmplPath)
	if err != nil {
		return err
	}

	data := map[string]string{
		"ModuleName":      moduleName,
		"ModuleNameLower": strings.ToLower(moduleName),
		"ModuleNameRoot":  moduleNameRoot,
	}

	var buf bytes.Buffer
	if err := tmpl.Execute(&buf, data); err != nil {
		return err
	}

	// Determine the output directory based on the kind of template
	var outputFile string
	if strings.HasPrefix(kind, "repo_model") {
		outputFile = filepath.Join(outputDir, "internal", "repository", "db", "model", strings.ToLower(moduleName)+".go")
	} else if strings.HasPrefix(kind, "repo_init") {
		outputFile = filepath.Join(outputDir, "internal", "repository", "db", strings.ToLower(moduleName), "impl", "init.go")
	} else if strings.HasPrefix(kind, "repo_iface") {
		outputFile = filepath.Join(outputDir, "internal", "repository", "db", strings.ToLower(moduleName), strings.ToLower(moduleName)+".go")
	} else if strings.HasPrefix(kind, "repo_create") {
		outputFile = filepath.Join(outputDir, "internal", "repository", "db", strings.ToLower(moduleName), "impl", "create.go")
	} else if strings.HasPrefix(kind, "repo_update") {
		outputFile = filepath.Join(outputDir, "internal", "repository", "db", strings.ToLower(moduleName), "impl", "update.go")
	} else if strings.HasPrefix(kind, "repo_delete") {
		outputFile = filepath.Join(outputDir, "internal", "repository", "db", strings.ToLower(moduleName), "impl", "delete.go")
	} else if strings.HasPrefix(kind, "repo_get") {
		outputFile = filepath.Join(outputDir, "internal", "repository", "db", strings.ToLower(moduleName), "impl", "get.go")
	}

	if strings.HasPrefix(kind, "usecase_model") {
		outputFile = filepath.Join(outputDir, "internal", "usecase", "model", strings.ToLower(moduleName)+".go")
	} else if strings.HasPrefix(kind, "usecase_init") {
		outputFile = filepath.Join(outputDir, "internal", "usecase", strings.ToLower(moduleName), "impl", "init.go")
	} else if strings.HasPrefix(kind, "usecase_iface") {
		outputFile = filepath.Join(outputDir, "internal", "usecase", strings.ToLower(moduleName), strings.ToLower(moduleName)+".go")
	} else if strings.HasPrefix(kind, "usecase_create") {
		outputFile = filepath.Join(outputDir, "internal", "usecase", strings.ToLower(moduleName), "impl", "create.go")
	}

	if err := os.MkdirAll(filepath.Dir(outputFile), 0755); err != nil {
		return err
	}

	return os.WriteFile(outputFile, buf.Bytes(), 0644)
}
