package impl

import (
	"context"
	omodel "{{.ModuleNameRoot}}/internal/outbound/model"
	umodel "{{.ModuleNameRoot}}/internal/usecase/model"
	pkgHelper "{{.ModuleNameRoot}}/pkg/helper"
)

func (u *usecase) Update(ctx context.Context, req *umodel.Update{{.ModuleName}}Request) error {
    span, ctx := pkgHelper.UpdateCtxSpanUsecase(ctx)
    defer span.End()
	data := omodel.Table{{.ModuleName}}{
		ID:   req.ID,
		Name: req.Name, // Add more fields as needed
	}
	_, err := u.{{.ModuleNameLower}}Repository.Update(ctx, data)
	return err
}
