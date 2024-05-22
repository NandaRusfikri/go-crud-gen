package impl

import (
	"context"
	"{{.ModuleNameRoot}}/internal/repository/db/model"
)

func (r *repository) Delete(ctx context.Context, id int64) error {
	err := r.db.WithContext(ctx).Where("id = ?", id).Delete(&model.Table{{.ModuleName}}{}).Error
	if err != nil {
		return err
	}
	return nil
}
