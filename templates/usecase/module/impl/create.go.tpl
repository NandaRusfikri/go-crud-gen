package impl

import (
	"context"
	omodel "{{.ModuleNameRoot}}/internal/outbound/model"
	umodel "{{.ModuleNameRoot}}/internal/usecase/model"
	pkgHelper "{{.ModuleNameRoot}}/pkg/helper"

)

func (u *usecase) Create(ctx context.Context, req *umodel.Create{{.ModuleName}}Request) error {
    span, ctx := pkgHelper.UpdateCtxSpanUsecase(ctx)
	defer span.End()

    data := omodel.Table{{.ModuleName}}{
        Name: req.Name,
    }
    return u.{{.ModuleNameLower}}Repository.Create(ctx, &data)
}