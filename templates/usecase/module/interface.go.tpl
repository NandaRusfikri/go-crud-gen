package {{.ModuleNameLower}}

import (
	"context"
	"{{.ModuleNameRoot}}/internal/usecase/model"
)

type (
    UseCase interface {
	    Create(ctx context.Context, req *model.Create{{.ModuleName}}Request) error
	    Delete(ctx context.Context, id uint64) error
	    GetByID(ctx context.Context, id uint64) (model.{{.ModuleName}}, error)
	    GetList(ctx context.Context, req model.Get{{.ModuleName}}Request) (model.List{{.ModuleName}}Response, error)
	    Update(ctx context.Context, req *model.Update{{.ModuleName}}Request) error
    }
)
