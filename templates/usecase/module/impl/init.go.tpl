package impl

import (
	u{{.ModuleName}} "{{.ModuleNameRoot}}/internal/usecase/{{.ModuleNameLower}}"
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