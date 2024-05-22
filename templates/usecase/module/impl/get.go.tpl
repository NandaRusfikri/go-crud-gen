package impl

import (
	"context"
	"{{.ModuleNameRoot}}/internal/usecase/model"
	rModel "{{.ModuleNameRoot}}/internal/repository/db/model"
)

func (u *usecase) GetByID(ctx context.Context, id uint64) (model.{{.ModuleName}}, error) {
	data, err := u.{{.ModuleNameLower}}Repository.GetByID(ctx, id)
	if err != nil {
		return model.{{.ModuleName}}{}, err
	}
	return model.{{.ModuleName}}{
		ID:   data.ID,
		Name: data.Name, // Add more fields as needed
	}, nil
}

func (u *usecase) GetList(ctx context.Context, req model.Get{{.ModuleName}}Request) ([]model.{{.ModuleName}}, error) {
	data, _, err := u.{{.ModuleNameLower}}Repository.GetList(ctx, rModel.GetListProductRequest{
        Page: req.Page,
        Limit: req.Limit,
        Search: req.Search,
        OrderField: req.OrderField,
    })
	if err != nil {
		return nil, err
	}
	var response []model.{{.ModuleName}}
	for _, d := range data {
		response = append(response, model.{{.ModuleName}}{
			ID:   d.ID,
			Name: d.Name, // Add more fields as needed
		})
	}
	return response, nil
}
