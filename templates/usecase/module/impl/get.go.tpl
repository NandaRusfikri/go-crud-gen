package impl

import (
	"context"
	omodel "{{.ModuleNameRoot}}/internal/outbound/model"
	umodel "{{.ModuleNameRoot}}/internal/usecase/model"
)

func (u *usecase) GetByID(ctx context.Context, id uint64) (umodel.{{.ModuleName}}, error) {
	data, err := u.{{.ModuleNameLower}}Repository.GetByID(ctx, id)
	if err != nil {
		return umodel.{{.ModuleName}}{}, err
	}
	return umodel.{{.ModuleName}}{
		ID:   data.ID,
		Name: data.Name, // Add more fields as needed
	}, nil
}

func (u *usecase) GetList(ctx context.Context, req umodel.Get{{.ModuleName}}Request) ([]umodel.{{.ModuleName}}, error) {
	data, _, err := u.{{.ModuleNameLower}}Repository.GetList(ctx, omodel.GetList{{.ModuleName}}Request{
        Page: req.Page,
        Limit: req.Limit,
        Search: req.Search,
        OrderField: req.OrderField,
    })
	if err != nil {
		return nil, err
	}
	var response []umodel.{{.ModuleName}}
	for _, d := range data {
		response = append(response, umodel.{{.ModuleName}}{
			ID:   d.ID,
			Name: d.Name, // Add more fields as needed
		})
	}
	return response, nil
}
