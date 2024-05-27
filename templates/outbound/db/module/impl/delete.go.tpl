package impl

import (
	"context"
	"{{.ModuleNameRoot}}/internal/outbound/model"
	pkgHelper "{{.ModuleNameRoot}}/pkg/helper"
)

func (r *repository) Delete(ctx context.Context, id uint64) error {
    span, ctx := pkgHelper.UpdateCtxSpanRepository(ctx)
	defer span.End()
	err := r.db.WithContext(ctx).Where("id = ?", id).Delete(&model.Table{{.ModuleName}}{}).Error
	if err != nil {
		return err
	}
	return nil
}
