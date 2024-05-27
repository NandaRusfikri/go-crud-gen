package impl

import (
	"context"
	"{{.ModuleNameRoot}}/internal/outbound/model"

)

func (r *repository) Create(ctx context.Context, data *model.Table{{.ModuleName}}) error {
	return r.db.WithContext(ctx).Create(data).Error
}




