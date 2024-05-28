package impl

import (
	"context"
	"fmt"
	"strings"
	"errors"
	"gorm.io/gorm"
	"{{.ModuleNameRoot}}/internal/outbound/model"
	pkgHelper "{{.ModuleNameRoot}}/pkg/helper"
)

func (r *repository) GetByID(ctx context.Context, id uint64) (model.Table{{.ModuleName}}, error) {
    span, ctx := pkgHelper.UpdateCtxSpanRepository(ctx)
	defer span.End()
	res := model.Table{{.ModuleName}}{}
	err := r.db.WithContext(ctx).Where("id = ?", id).First(&res).Error
	if err != nil {
		return model.Table{{.ModuleName}}{}, nil
	}
	return res, nil
}

func (r *repository) GetList(ctx context.Context, request model.GetList{{.ModuleName}}Request) (list []model.Table{{.ModuleName}}, count int64, err error) {
    span, ctx := pkgHelper.UpdateCtxSpanRepository(ctx)
	defer span.End()
	var params []interface{}
	var limitOffset, orderByQuery string
	Select := fmt.Sprintf("SELECT id, module, feature FROM {{.ModuleNameLower}} ")

	selectCount := fmt.Sprintf("SELECT COUNT(id) FROM {{.ModuleNameLower}} ")

	where := fmt.Sprintf("WHERE {{.ModuleNameLower}}.id IS NOT NULL ")
	SearchText := "%" + strings.ToLower(request.Search) + "%"
	if request.Search != "" {
		where += " AND (LOWER(name) LIKE ? ) "
		params = append(params, SearchText)
	}

	if request.Limit > 0 && request.Page > 0 {
		offset := request.Page*request.Limit - request.Limit
		limitOffset = fmt.Sprintf("LIMIT %v OFFSET %v", request.Limit, offset)
	}

	query := fmt.Sprintf("%v %v %v %v", Select, where, orderByQuery, limitOffset)
	find := r.db.WithContext(ctx).Raw(query, params...).Scan(&list)
	if find.Error != nil {
		if errors.Is(find.Error, gorm.ErrRecordNotFound) {
			return nil, 0, find.Error
		}
		return nil, 0, find.Error
	}

	queryCount := fmt.Sprintf("%v %v", selectCount, where)
	countFind := r.db.WithContext(ctx).Raw(queryCount, params...).Count(&count)
	if countFind.Error != nil {
		return nil, 0, countFind.Error
	}

	return
}

