package impl

import (
	"gorm.io/gorm"
	"{{.ModuleNameRoot}}/internal/outbound/db/{{.ModuleNameLower}}"
	"{{.ModuleNameRoot}}/pkg/resource/model"
)

type repository struct {
	db *gorm.DB
}

func New(db model.Database) {{.ModuleNameLower}}.Repository {
	return &repository{db: db.Template}
}


