package impl

import (
	"context"
	omodel "{{.ModuleNameRoot}}/internal/outbound/model"
	umodel "{{.ModuleNameRoot}}/internal/usecase/model"

)

func (u *usecase) Create(ctx context.Context, req *umodel.Create{{.ModuleName}}Request) error {

    data := omodel.Table{{.ModuleName}}{
        Name: req.Name,
    }
    return u.{{.ModuleNameLower}}Repository.Create(ctx, &data)
}