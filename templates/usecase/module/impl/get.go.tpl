package impl

import (
	"context"
	omodel "{{.ModuleNameRoot}}/internal/outbound/model"
	umodel "{{.ModuleNameRoot}}/internal/usecase/model"
	pkgHelper "{{.ModuleNameRoot}}/pkg/helper"
)

func (u *usecase) GetByID(ctx context.Context, id uint64) (umodel.{{.ModuleName}}, error) {
    span, ctx := pkgHelper.UpdateCtxSpanUsecase(ctx)
    defer span.End()
	data, err := u.{{.ModuleNameLower}}Repository.GetByID(ctx, id)
	if err != nil {
		return umodel.{{.ModuleName}}{}, err
	}
	return umodel.{{.ModuleName}}{
		ID:   data.ID,
		Name: data.Name, // Add more fields as needed
	}, nil
}

func (u *usecase) GetList(ctx context.Context, req umodel.Get{{.ModuleName}}Request) (umodel.List{{.ModuleName}}Response, error) {
    span, ctx := pkgHelper.UpdateCtxSpanUsecase(ctx)
    defer span.End()
	data, count, err := u.{{.ModuleNameLower}}Repository.GetList(ctx, omodel.GetList{{.ModuleName}}Request{
        Page: req.Page,
        Limit: req.Limit,
        Search: req.Search,
        OrderField: req.OrderField,
    })
	if err != nil {
		return umodel.List{{.ModuleName}}Response{}, err
	}
	var list []umodel.{{.ModuleName}}
	for _, d := range data {
		list = append(list, umodel.{{.ModuleName}}{
			ID:   d.ID,
			Name: d.Name, // Add more fields as needed
		})
	}
	return umodel.List{{.ModuleName}}Response{
	    PageTotal:   0,
        PageCurrent: 0,
        Count:       count,
        Users:       list,
	}, nil
}
