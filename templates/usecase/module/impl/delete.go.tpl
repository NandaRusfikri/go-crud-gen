package impl

import (
	"context"
	pkgHelper "{{.ModuleNameRoot}}/pkg/helper"
)

func (u *usecase) Delete(ctx context.Context, id uint64) error {
    span, ctx := pkgHelper.UpdateCtxSpanUsecase(ctx)
    defer span.End()
	return u.{{.ModuleNameLower}}Repository.Delete(ctx, id)
}
