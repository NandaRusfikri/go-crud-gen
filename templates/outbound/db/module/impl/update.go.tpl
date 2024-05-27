package impl

import (
	"context"
	"{{.ModuleNameRoot}}/internal/outbound/model"
	pkgHelper "{{.ModuleNameRoot}}/pkg/helper"
)

func (r *repository) Update(ctx context.Context, req model.Table{{.ModuleName}}) (model.Table{{.ModuleName}}, error) {
    span, ctx := pkgHelper.UpdateCtxSpanRepository(ctx)
	defer span.End()
	result := r.db.WithContext(ctx).Where("id = ?", req.ID).Updates(&req)
	if result.Error != nil {
		return model.Table{{.ModuleName}}{}, result.Error
	}
	return req, nil
}
