package impl

import (
	"context"
	"{{.ModuleNameRoot}}/internal/usecase/model"
	dbModel "{{.ModuleNameRoot}}/internal/repository/db/model"
)

func (u *usecase) Update(ctx context.Context, req *model.Update{{.ModuleName}}Request) error {
	data := dbModel.Table{{.ModuleName}}{
		ID:   req.ID,
		Name: req.Name, // Add more fields as needed
	}
	_, err := u.{{.ModuleNameLower}}Repository.Update(ctx, data)
	return err
}
