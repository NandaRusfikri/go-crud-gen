package impl

import (
	"context"
	"{{.ModuleNameRoot}}/internal/usecase/model"
	dbModel "{{.ModuleNameRoot}}/internal/repository/db/model"
)

func (u *usecase) Create(ctx context.Context, req *model.Create{{.ModuleName}}Request) error {

    data := dbModel.Table{{.ModuleName}}{
        Name: req.Name,
    }
    return u.{{.ModuleNameLower}}Repository.Create(ctx, &data)
}