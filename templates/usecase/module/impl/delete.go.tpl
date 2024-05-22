package impl

import (
	"context"
)

func (u *usecase) Delete(ctx context.Context, id uint64) error {
	return u.{{.ModuleNameLower}}Repository.Delete(ctx, id)
}
