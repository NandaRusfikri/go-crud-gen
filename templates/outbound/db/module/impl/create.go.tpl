package impl

import (
	"context"
	"{{.ModuleNameRoot}}/internal/outbound/model"
	pkgHelper "{{.ModuleNameRoot}}/pkg/helper"

)

func (r *repository) Create(ctx context.Context, data *model.Table{{.ModuleName}}) error {
    span, ctx := pkgHelper.UpdateCtxSpanRepository(ctx)
	defer span.End()
	return r.db.WithContext(ctx).Table("{{.ModuleNameLower}}").Create(data).Error
}




