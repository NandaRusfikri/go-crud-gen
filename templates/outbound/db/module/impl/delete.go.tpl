package impl

import (
	"context"
	"{{.ModuleNameRoot}}/internal/outbound/model"
)

func (r *repository) Delete(ctx context.Context, id uint64) error {
	err := r.db.WithContext(ctx).Where("id = ?", id).Delete(&model.Table{{.ModuleName}}{}).Error
	if err != nil {
		return err
	}
	return nil
}
