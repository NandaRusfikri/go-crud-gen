package impl

import (
	"context"
	omodel "{{.ModuleNameRoot}}/internal/outbound/model"
	umodel "{{.ModuleNameRoot}}/internal/usecase/model"
)

func (u *usecase) Update(ctx context.Context, req *umodel.Update{{.ModuleName}}Request) error {
	data := omodel.Table{{.ModuleName}}{
		ID:   req.ID,
		Name: req.Name, // Add more fields as needed
	}
	_, err := u.{{.ModuleNameLower}}Repository.Update(ctx, data)
	return err
}
