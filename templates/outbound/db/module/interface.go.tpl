package {{.ModuleNameLower}}

import (
	"context"
	"{{.ModuleNameRoot}}/internal/outbound/model"
)

type Repository interface {
	Create(ctx context.Context, data *model.Table{{.ModuleName}}) error
    Delete(ctx context.Context, id uint64) error
   	Update(ctx context.Context, req model.Table{{.ModuleName}}) (model.Table{{.ModuleName}}, error)
   	GetByID(ctx context.Context, id uint64) (model.Table{{.ModuleName}}, error)
   	GetList(ctx context.Context, request model.GetList{{.ModuleName}}Request) ([]model.Table{{.ModuleName}}, int64, error)
}
