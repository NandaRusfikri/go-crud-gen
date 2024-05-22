package impl

import (
	"gorm.io/gorm"
	"{{.ModuleNameRoot}}/internal/repository/db/{{.ModuleNameLower}}"
)

type repository struct {
	db *gorm.DB
}

func New(db *gorm.DB) {{.ModuleNameLower}}.Repository {
	return &repository{db: db}
}
