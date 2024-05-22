package impl

import (
	"context"
	"{{.ModuleNameRoot}}/internal/usecase/model"
	dbmodel "{{.ModuleNameRoot}}/internal/repository/db/model"
)

func (u usecase) Create(ctx context.Context, req *model.Create{{.ModuleName}}Request) error {

    data := dbmodel.Table{{.ModuleName}}{
        Name: req.Name,
    }
    return u.{{.ModuleNameLower}}Repository.Create(ctx, &data)
}