package impl

import (
	uUser "go-crud-gen/internal/usecase/user"
	"{{.ModuleNameRoot}}/internal/repository/db/{{.ModuleNameLower}}"
)

type usecase struct {
	{{.ModuleNameLower}}Repository {{.ModuleNameLower}}.Repository
}


func New({{.ModuleNameLower}}Repository {{.ModuleNameLower}}.Repository) u{{.ModuleName}}.UseCase {
	return &usecase{
		{{.ModuleNameLower}}Repository: {{.ModuleNameLower}}Repository,
	}
}