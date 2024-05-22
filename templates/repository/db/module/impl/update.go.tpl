package impl

import (
	"context"
	"{{.ModuleNameRoot}}/internal/repository/db/model"
)

func (r *repository) Update(ctx context.Context, req model.Table{{.ModuleName}}) (model.Table{{.ModuleName}}, error) {
	result := r.db.WithContext(ctx).Where("id = ?", req.ID).Updates(&req)
	if result.Error != nil {
		return model.Table{{.ModuleName}}{}, result.Error
	}
	return req, nil
}
