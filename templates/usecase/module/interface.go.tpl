package {{.ModuleNameLower}}

import (
	"context"
	"{{.ModuleNameRoot}}/internal/usecase/model"
)

type UseCase interface {
	Create(ctx context.Context, req *model.Create{{.ModuleName}}Request) error
}
